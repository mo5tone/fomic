import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fomic/model/constant/SourceName.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/source/Source.dart';

class Dmzj extends Source {
  final _baseUrl = 'http://v3api.dmzj.com';

  @override
  SourceName get name => SourceName.dmzj;

  @override
  Future<List<Book>> fetchBooks({int page = 0, String query}) {
    String path;
    RequestOptions options;
    if (query != null && query.isNotEmpty) {
      path = 'http://s.acg.dmzj.com/comicsum/search.php';
      options = RequestOptions(method: 'GET', queryParameters: {'s': query}, responseType: ResponseType.plain);
    } else {
      path = 'http://v2.api.dmzj.com/classify/0/1/$page.json';
      options = RequestOptions(method: 'GET');
    }
    return dio.request(path, options: options).then(_booksFrom);
  }

  @override
  Future<Book> fetchBook(Book book) {
    final path = book.url;
    final options = RequestOptions(method: 'GET', baseUrl: _baseUrl);
    return dio.request(path, options: options).then(_bookFrom);
  }

  @override
  Future<List<Chapter>> fetchChapters(Book book) {
    final path = book.url;
    final options = RequestOptions(method: 'GET', baseUrl: _baseUrl);
    return dio.request(path, options: options).then(_chaptersFrom);
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    final path = chapter.url;
    final options = RequestOptions(method: 'GET', baseUrl: _baseUrl);
    return dio.request(path, options: options).then(_pagesFrom);
  }

  List<Book> _booksFrom(Response response) {
    if (response.request.responseType == ResponseType.plain) {
      String body = response.data;
      final regExp = RegExp(r'^var g_search_data =([\s\S]+);$');
      final match = regExp.firstMatch(body);
      List arr = jsonDecode(match.group(1));
      return arr.map((ele) {
        int id = ele['id'];
        String title = ele['comic_name'];
        String thumbnailUrl = ele['comic_cover'];
        String author = ele['comic_author'];
        final url = '/comic/comic_$id.json?version=2.7.019';
        return Book(url: url, title: title, thumbnailUrl: thumbnailUrl, author: author);
      }).toList();
    } else {
      List arr = response.data;
      return arr.map((ele) {
        int id = ele['id'];
        String title = ele['title'];
        String thumbnailUrl = ele['cover'];
        String author = ele['authors'];
        final url = '/comic/comic_$id.json?version=2.7.019';
        var status = ele['status'];
        status = status == '已完结' ? 2 : status == '连载中' ? 1 : 0;
        return Book(url: url, title: title, thumbnailUrl: thumbnailUrl, author: author, status: status);
      }).toList();
    }
  }

  Book _bookFrom(Response response) {
    Map<String, dynamic> obj = response.data;
    String title = obj['title'];
    String thumbnailUrl = obj['cover'];
    List<Map<String, dynamic>> arr = obj['authors'];
    final authors = arr.map((ele) => ele['tag_name'] as String).join(', ');
    arr = obj['types'];
    final genre = arr.map((ele) => ele['tag_name'] as String).join(', ');
    int status = obj['status'][0]['tag_id'];
    status -= 2308;
    String description = obj['description'];
    return Book(
      url: response.request.path,
      title: title,
      thumbnailUrl: thumbnailUrl,
      author: authors,
      status: status,
      genre: genre,
      description: description,
    );
  }

  List<Chapter> _chaptersFrom(Response response) {
    Map<String, dynamic> obj = response.data;
    String id = obj['id'];
    List<Map<String, dynamic>> arr = obj['chapters'];
    final result = arr.map((ele) {
      String prefix = ele['title'];
      List<Map<String, dynamic>> arr1 = ele['data'];
      return arr1.map((ele1) {
        final name = '$prefix: ${ele1['chapter_title']}';
        int updatedAt = ele1['updatetime'];
        updatedAt *= 1000;
        String chapterId = ele1['chapter_id'];
        final url = '/chapter/$id/$chapterId.json';
        // final url = 'http://m.dmzj.com/chapinfo/$id/$chapterId.html';
        return Chapter(url: url, name: name, updatedAt: updatedAt);
      });
    });
    return result.reduce((value, element) => [...value, ...element]);
  }

  List<Page> _pagesFrom(Response response) {
    Map<String, dynamic> obj = response.data;
    List<String> arr = obj['page_url'];
    final result = <Page>[];
    for (var i = 0; i < arr.length; i++) {
      result.add(Page(index: i, imageUrl: arr[i]));
    }
    return result;
  }
}

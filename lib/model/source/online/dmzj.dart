import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/source/online_source.dart';

class DMZJ extends OnlineSource {
  final _baseUrl = 'http://v3api.dmzj.com';

  @override
  String get languageCode => 'zh';

  @override
  String get name => '动漫之家';

  @override
  BaseOptions get baseOptions => BaseOptions(
        headers: {
          'User-Agent': const <String>[
            'Mozilla/5.0 (X11; Linux x86_64)',
            'AppleWebKit/537.36 (KHTML, like Gecko)',
            'Chrome/56.0.2924.87',
            'Safari/537.36',
            'Fomic/1.0',
          ].join(' '),
        },
      );

  @override
  RequestOptions fetchBooksRequest({int page = 0, String query}) => query == null || query.isEmpty
      ? RequestOptions(
          method: 'GET',
          path: 'http://v2.api.dmzj.com/classify/0/1/$page.json',
        )
      : RequestOptions(
          method: 'GET',
          path: 'http://s.acg.dmzj.com/comicsum/search.php',
          queryParameters: {'s': query},
          responseType: ResponseType.plain,
        );

  @override
  RequestOptions fetchBookRequest(Book book) => RequestOptions(method: 'GET', path: book.url, baseUrl: _baseUrl);

  @override
  RequestOptions fetchChaptersRequest(Book book) => RequestOptions(method: 'GET', path: book.url, baseUrl: _baseUrl);

  @override
  RequestOptions fetchPagesRequest(Chapter chapter) =>
      RequestOptions(method: 'GET', path: chapter.url, baseUrl: _baseUrl);

  @override
  List<Book> booksParser(Response response) {
    if (response.request.responseType == ResponseType.plain) {
      String body = response.data;
      final regExp = RegExp(r'^var g_search_data =([\s\S]+);$');
      final match = regExp.firstMatch(body);
      List arr = jsonDecode(match.group(1));
      return arr.map((ele) {
        int id = ele['id'];
        String title = ele['comic_name'];
        String thumbnailUrl = ele['comic_cover'];
        if (thumbnailUrl.startsWith('//')) {
          thumbnailUrl = 'http:$thumbnailUrl';
        }
        String author = ele['comic_author'];
        final url = '/comic/comic_$id.json?version=2.7.019';
        return Book(
          url: url,
          title: title,
          thumbnail: RequestOptions(
            path: thumbnailUrl,
            baseUrl: _baseUrl,
            headers: baseOptions.headers,
          ),
          author: author,
        );
      }).toList();
    } else {
      List arr = response.data;
      return arr.map((ele) {
        int id = ele['id'];
        String title = ele['title'];
        String thumbnailUrl = ele['cover'];
        String author = ele['authors'];
        final url = '/comic/comic_$id.json?version=2.7.019';
        return Book(
          url: url,
          title: title,
          thumbnail: RequestOptions(
            path: thumbnailUrl,
            baseUrl: _baseUrl,
            headers: baseOptions.headers,
          ),
          author: author,
          status: _statusFrom(ele['status']),
        );
      }).toList();
    }
  }

  @override
  Book bookParser(Response response) {
    Map<String, dynamic> obj = response.data;
    String title = obj['title'];
    String thumbnailUrl = obj['cover'];
    List<Map<String, dynamic>> arr = obj['authors'];
    final authors = arr.map((ele) => ele['tag_name'] as String).join(', ');
    arr = obj['types'];
    final genre = arr.map((ele) => ele['tag_name'] as String).join(', ');
    String description = obj['description'];
    return Book(
      url: response.request.path,
      title: title,
      thumbnail: RequestOptions(
        path: thumbnailUrl,
        baseUrl: _baseUrl,
        headers: baseOptions.headers,
      ),
      author: authors,
      status: _statusFrom(obj['status'][0]['tag_id']),
      genre: genre,
      description: description,
    );
  }

  @override
  List<Chapter> chaptersParser(Response response) {
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

  @override
  List<Page> pagesParser(Response response) {
    Map<String, dynamic> obj = response.data;
    List<String> arr = obj['page_url'];
    final result = <Page>[];
    for (var i = 0; i < arr.length; i++) {
      final imageReq = RequestOptions(
        path: arr[i],
        baseUrl: _baseUrl,
        headers: baseOptions.headers,
      );
      result.add(Page(index: i, image: imageReq));
    }
    return result;
  }

  int _statusFrom(dynamic value) {
    var status = Book.unknown;
    if (value is String) {
      switch (value) {
        case '已完结':
          status = Book.completed;
          break;
        case '连载中':
          status = Book.ongoing;
          break;
        default:
          break;
      }
    } else if (value is int) {
      switch (value) {
        case 2310:
          status = Book.completed;
          break;
        case 2309:
          status = Book.ongoing;
          break;
        default:
          break;
      }
    }
    return status;
  }
}

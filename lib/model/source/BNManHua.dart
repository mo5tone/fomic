import 'dart:convert';

import 'package:fomic/model/entity/ImageRequest.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/constant/SourceID.dart';
import 'package:dio/dio.dart';
import 'package:fomic/model/source/Source.dart';
import 'package:html/parser.dart';

class BNManHua extends Source {
  final _baseURL = 'https://m.bnmanhua.com';
  Map<String, String> get _headers => {
        'Referer': _baseURL,
      };

  @override
  SourceID get id => SourceID.bnmanhua;

  @override
  BaseOptions get baseOptions => BaseOptions(
        headers: _headers,
      );

  @override
  RequestOptions booksRequest({int page = 0, String query}) => query == null || query.isEmpty
      ? RequestOptions(
          method: 'GET',
          path: '/index.php',
          queryParameters: {
            'm': 'vod-search-pg-$page-wd-$query.html',
          },
          baseUrl: _baseURL,
        )
      : RequestOptions(
          method: 'GET',
          path: '/page/hot/$page.html',
          baseUrl: _baseURL,
        );

  @override
  RequestOptions bookRequest(Book book) => RequestOptions(method: 'GET', path: book.url, baseUrl: _baseURL);

  @override
  RequestOptions chaptersRequest(Book book) => RequestOptions(method: 'GET', path: book.url, baseUrl: _baseURL);

  @override
  RequestOptions pagesRequest(Chapter chapter) => RequestOptions(method: 'GET', path: chapter.url, baseUrl: _baseURL);

  @override
  List<Book> booksFromResponse(Response response) {
    final doc = parse(response.data);
    final elements = doc.querySelectorAll('ul.tbox_m>li.vbox');
    return elements.map((ele) {
      final aEle = ele.querySelector('a.vbox_t');
      final url = aEle.attributes['href'];
      final title = aEle.attributes['title'].trim();
      final imgEle = ele.querySelector('mip-img');
      final thumbnailRequest = ImageRequest(
        imgEle.attributes['src'],
        headers: _headers,
      );
      return Book(url: url, title: title, thumbnailRequest: thumbnailRequest);
    }).toList();
  }

  @override
  Book bookFromResponse(Response response) {
    final doc = parse(response.data);
    final element = doc.querySelector('div.data');
    return Book(
      author: element.querySelector('p.dir').text.substring(3).trim(),
      description: doc.querySelector('div.tbox_js').text.trim(),
    );
  }

  @override
  List<Chapter> chaptersFromResponse(Response response) {
    final doc = parse(response.data);
    final elements = doc.querySelectorAll('ul.list_block>li');
    return elements.map((ele) {
      final aEle = ele.querySelector('a');
      return Chapter(url: aEle.attributes['href'], name: aEle.text.trim());
    }).toList();
  }

  @override
  List<Page> pagesFromResponse(Response response) {
    final String body = response.data;
    var regExp = RegExp(r"^var z_yurl='(.*?)';$");
    var match = regExp.firstMatch(body);
    final baseImageURL = match.group(1);
    regExp = RegExp(r"^var z_img='(.*?)';$");
    match = regExp.firstMatch(body);
    final imageCodes = match.group(1);
    if (imageCodes == null) {
      return [];
    }
    final List<String> codes = jsonDecode(imageCodes);
    var pages = <Page>[];
    for (var i = 0; i < codes.length; i++) {
      pages.add(Page(index: i, imageUrl: '$baseImageURL${codes[i]}'));
    }
    return pages;
  }
}

import 'dart:convert';

import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/constant/repository_id.dart';
import 'package:dio/dio.dart';
import 'package:fomic/model/repository/repository.dart';
import 'package:html/parser.dart';

class BNManHua extends Repository {
  final _baseUrl = 'https://m.bnmanhua.com';

  @override
  RepositoryID get id => RepositoryID.bnmanhua;

  @override
  BaseOptions get baseOptions => BaseOptions(
        headers: {
          'Referer': _baseUrl,
        },
      );

  @override
  RequestOptions booksRequest({int page = 0, String query}) => query == null || query.isEmpty
      ? RequestOptions(
          method: 'GET',
          path: '/page/hot/$page.html',
          baseUrl: _baseUrl,
        )
      : RequestOptions(
          method: 'POST',
          path: '/search.html',
          data: {'keyword': query},
          baseUrl: _baseUrl,
        );

  @override
  RequestOptions bookRequest(Book book) => RequestOptions(method: 'GET', path: book.url, baseUrl: _baseUrl);

  @override
  RequestOptions chaptersRequest(Book book) => RequestOptions(method: 'GET', path: book.url, baseUrl: _baseUrl);

  @override
  RequestOptions pagesRequest(Chapter chapter) => RequestOptions(method: 'GET', path: chapter.url, baseUrl: _baseUrl);

  @override
  List<Book> booksFromResponse(Response response) {
    final doc = parse(response.data);
    final elements = doc.querySelectorAll('ul.tbox_m>li.vbox');
    return elements.map((ele) {
      final aEle = ele.querySelector('a.vbox_t');
      final url = aEle.attributes['href'];
      final title = aEle.attributes['title'].trim();
      final imgEle = ele.querySelector('mip-img');
      return Book(
        url: url,
        title: title,
        thumbnail: RequestOptions(
          path: imgEle.attributes['src'],
          baseUrl: _baseUrl,
          headers: baseOptions.headers,
        ),
      );
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
      final imageReq = RequestOptions(
        path: '$baseImageURL${codes[i]}',
        baseUrl: _baseUrl,
        headers: baseOptions.headers,
      );
      pages.add(Page(index: i, image: imageReq));
    }
    return pages;
  }
}

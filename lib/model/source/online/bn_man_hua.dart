import 'dart:convert';

import 'package:fomic/common/constant/source_id.dart';
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:dio/dio.dart';
import 'package:fomic/model/source/online_source.dart';
import 'package:html/parser.dart';

class BNManHua extends OnlineSource {
  final _baseUrl = 'https://m.bnmanhua.com';

  @override
  SourceId get id => SourceId.bnManHua;

  @override
  BaseOptions get baseOptions => BaseOptions(
        headers: {
          'Referer': _baseUrl,
        },
      );

  @override
  RequestOptions fetchBooksRequest({int page = 0, String query}) => (query?.isEmpty ?? true)
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
  RequestOptions fetchBookRequest(Book book) => RequestOptions(
        method: 'GET',
        path: book.url,
        baseUrl: _baseUrl,
      );

  @override
  RequestOptions fetchChaptersRequest(Book book) => RequestOptions(
        method: 'GET',
        path: book.url,
        baseUrl: _baseUrl,
      );

  @override
  RequestOptions fetchPagesRequest(Chapter chapter) => RequestOptions(
        method: 'GET',
        path: chapter.url,
        baseUrl: _baseUrl,
      );

  @override
  List<Book> booksParser(Response response) {
    final doc = parse(response.data);
    final elements = doc.querySelectorAll('ul.tbox_m>li.vbox');
    return elements.map((ele) {
      final aEle = ele.querySelector('a.vbox_t');
      final url = aEle.attributes['href'];
      final title = aEle.attributes['title'].trim();
      final imgEle = ele.querySelector('mip-img');
      final thumbnailReq = RequestOptions(
        path: imgEle.attributes['src'],
        baseUrl: _baseUrl,
        headers: baseOptions.headers,
      );
      return Book(
        url,
        title: title,
        thumbnailUrl: thumbnailReq.uri.toString(),
        thumbnailHeaders: thumbnailReq.headers,
      );
    }).toList();
  }

  @override
  Book bookParser(Response response) {
    Book origin = response.request.extra['book'];
    final doc = parse(response.data);
    final element = doc.querySelector('div.data');
    return origin
      ..author = element.querySelector('p.dir').text.substring(3).trim()
      ..description = doc.querySelector('div.tbox_js').text.trim();
  }

  @override
  List<Chapter> chaptersParser(Response response) {
    final doc = parse(response.data);
    final elements = doc.querySelectorAll('ul.list_block>li');
    return elements.map((ele) {
      final aEle = ele.querySelector('a');
      return Chapter(aEle.attributes['href'], name: aEle.text.trim());
    }).toList();
  }

  @override
  List<Page> pagesParser(Response response) {
    var pages = <Page>[];
    final String body = response.data;
    // var regExp = RegExp(r"^var z_yurl='(.*?)';$");
    // var match = regExp.firstMatch(body);
    // final baseImageURL = match.group(1);
    final baseImageURL = 'https://img.yaoyaoliao.com/'; // match.group(1);
    final regExp = RegExp(r"var z_img='(.*?)';");
    final match = regExp.firstMatch(body);
    final imageCodes = match?.group(1);
    if (imageCodes != null) {
      final List codes = jsonDecode(imageCodes);
      for (var i = 0; i < codes.length; i++) {
        final imageReq = RequestOptions(
          path: '${codes[i]}',
          baseUrl: baseImageURL,
          headers: baseOptions.headers,
        );
        pages.add(Page(index: i, imageUrl: imageReq.uri.toString(), imageHeaders: imageReq.headers));
      }
    }
    return pages;
  }
}

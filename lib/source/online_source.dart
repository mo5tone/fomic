import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/constant/source_id.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/model/chapter.dart';
import 'package:fomic/source/model/page.dart';
import 'package:fomic/source/source.dart';
import 'package:html/parser.dart';

part './online/dmzj.dart';
part './online/bn_man_hua.dart';

abstract class OnlineSource extends Source {
  Dio _dio;

  @protected
  Dio get dio {
    _dio ??= Dio(baseOptions.merge(connectTimeout: 5000, receiveTimeout: 3000, sendTimeout: 3000));
    return _dio;
  }

  @protected
  BaseOptions get baseOptions;

  @protected
  RequestOptions fetchBooksRequest({int page = 0, String query});

  @protected
  RequestOptions fetchBookRequest(Book book);

  @protected
  RequestOptions fetchChaptersRequest(Book book);

  @protected
  RequestOptions fetchPagesRequest(Chapter chapter);

  @protected
  List<Book> booksParser(Response response);

  @protected
  Book bookParser(Response response);

  @protected
  List<Chapter> chaptersParser(Response response);

  @protected
  List<Page> pagesParser(Response response);

  @override
  Future<List<Book>> fetchBooks({int page = 0, String query}) {
    final req = fetchBooksRequest(page: page, query: query);
    req.extra = {'page': page, 'query': query};
    return dio.request(req.path, options: req).then(booksParser);
  }

  @override
  Future<Book> fetchBook(Book book) {
    final req = fetchBookRequest(book);
    req.extra = {'book': book};
    return dio.request(req.path, options: req).then(bookParser);
  }

  @override
  Future<List<Chapter>> fetchChapters(Book book) {
    final req = fetchChaptersRequest(book);
    req.extra = {'book': book};
    return dio.request(req.path, options: req).then(chaptersParser);
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    final req = fetchPagesRequest(chapter);
    req.extra = {'chapter': chapter};
    return dio.request(req.path, options: req).then(pagesParser);
  }
}

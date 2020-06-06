import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:fomic/model/constant/SourceName.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/source/Dmzj.dart';
import 'package:get_it/get_it.dart';

abstract class Source {
  @protected
  final dio = GetIt.I.get<Dio>();

  SourceName get name;
  Future<List<Book>> fetchBooks({int page = 0, String query});
  Future<Book> fetchBook(Book book);
  Future<List<Chapter>> fetchChapters(Book book);
  Future<List<Page>> fetchPages(Chapter chapter);

  Source();

  factory Source.of(SourceName name) {
    switch (name) {
      case SourceName.dmzj:
        return Dmzj();
      default:
        return null;
    }
  }
}

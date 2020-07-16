import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:fomic/model/constant/SourceID.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/source/Dmzj.dart';
import 'package:get_it/get_it.dart';

abstract class Source {
  @protected
  final dio = GetIt.I.get<Dio>();

  SourceID get id;
  Future<List<Book>> fetchBooks({int page = 0, String query});
  Future<Book> fetchBook(Book book);
  Future<List<Chapter>> fetchChapters(Book book);
  Future<List<Page>> fetchPages(Chapter chapter);

  Source();

  factory Source.of(SourceID id) {
    switch (id) {
      case SourceID.dmzj:
        return Dmzj();
      default:
        return null;
    }
  }
}

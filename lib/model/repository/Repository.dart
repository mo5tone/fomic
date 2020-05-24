import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/entity/RepositoryName.dart';
import 'package:fomic/model/repository/Dmzj.dart';
import 'package:injector/injector.dart';

abstract class Repository {
  @protected
  final dio = Injector.appInstance.getDependency<Dio>();
  RepositoryName get name;

  Future<List<Book>> fetchBooks({int page = 0, String query});
  Future<Book> fetchBook(Book book);
  Future<List<Chapter>> fetchChapters(Book book);
  Future<List<Page>> fetchPages(Chapter chapter);

  Repository();

  factory Repository.of(RepositoryName name) {
    switch (name) {
      case RepositoryName.dmzj:
        return Dmzj();
      default:
        return null;
    }
  }
}

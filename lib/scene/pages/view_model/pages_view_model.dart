import 'package:flutter/material.dart' hide Page;
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/source/source.dart';
import 'package:fomic/scene/view_model.dart';

class PagesViewModel extends ViewModel {
  final Source source;
  final Book book;
  final Chapter chapter;

  var _pages = <Page>[];

  List<Page> get pages => _pages;

  @protected
  set pages(List<Page> value) {
    _pages = value ?? [];
    notifyListeners();
  }

  PagesViewModel(this.source, this.book, this.chapter) {
    fetch();
  }

  Future<void> fetch() {
    if (loading) return Future.value();
    loading = true;
    return source
        .fetchPages(chapter)
        .then((value) => pages = value)
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }
}

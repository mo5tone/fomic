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

  int _index;
  var _pages = <Page>[];

  int get index => _index;
  List<Page> get pages => _pages;

  @protected
  set pages(List<Page> value) {
    _pages = value ?? [];
    if (_pages.isNotEmpty) _index = 0;
    notifyListeners();
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  PagesViewModel(this.source, this.book, this.chapter) {
    fetch();
  }

  Future<void> fetch() {
    if (loading) return Future.value();
    loading = true;
    return source.fetchPages(chapter).then((value) => pages = value).catchError((err) => message = err.toString()).whenComplete(() => loading = false);
  }
}

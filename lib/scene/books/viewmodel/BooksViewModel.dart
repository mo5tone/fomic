import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fomic/model/constant/SourceName.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/source/Source.dart';

class BooksViewModel with ChangeNotifier {
  final Source _source;
  var _page = -1;
  var _query = '';
  var _loading = false;
  var _books = <Book>[];

  List<Book> get books => _books;

  bool get loading => _loading;

  void _setLoading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  BooksViewModel(SourceName sourceName) : _source = Source.of(sourceName);

  Future<void> load() {
    if (loading) return Future.value();
    _setLoading(true);
    return _source
        .fetchBooks(page: _page + 1, query: _query)
        .then((value) => _books += value)
        .then((_) => notifyListeners())
        .then((_) => _page += 1)
        .whenComplete(() => _setLoading(false));
  }

  Future<void> refresh() {
    if (loading) return Future.value();
    _setLoading(true);
    return _source
        .fetchBooks(page: 0, query: _query)
        .then((value) => _books = value)
        .then((_) => notifyListeners())
        .then((_) => _page = 0)
        .whenComplete(() => _setLoading(false));
  }
}

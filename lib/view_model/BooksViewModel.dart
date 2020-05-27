import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fomic/model/constant/SourceName.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/source/Source.dart';

class BooksViewModel extends ChangeNotifier {
  final Source _source;
  var _isLoading = false;
  final _books = <Book>[];
  var _page = 0;
  var _query = '';
  final _loading = StreamController();

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  BooksViewModel({@required SourceName sourceName}) : _source = Source.of(sourceName);

  void load() {
    if (_isLoading) return;
    _source.fetchBooks(page: _page, query: _query);
  }
}

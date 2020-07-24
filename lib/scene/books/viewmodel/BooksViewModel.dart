import 'dart:async';

import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/source/Source.dart';
import 'package:fomic/scene/ViewModel.dart';

class BooksViewModel extends ViewModel {
  final Source _source;
  var _page = 0;
  var _books = <Book>[];

  List<Book> get books => _books;

  BooksViewModel(SourceId sourceId) : _source = Source.of(sourceId);

  Future<void> load() {
    if (loading.value) return Future.value();
    loading.value = true;
    return _source
        .fetchBooks(page: _page)
        .then((value) => _books += value)
        .then((_) => notifyListeners())
        .then((_) => _page += 1)
        .whenComplete(() => loading.value = false);
  }

  Future<void> refresh() {
    if (loading.value) return Future.value();
    loading.value = true;
    return _source
        .fetchBooks(page: 0)
        .then((value) => _books = value)
        .then((_) => notifyListeners())
        .then((_) => _page = 0)
        .whenComplete(() => loading.value = false);
  }
}

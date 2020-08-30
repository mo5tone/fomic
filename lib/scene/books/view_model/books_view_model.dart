import 'dart:async';

import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/source/source.dart';
import 'package:fomic/scene/view_model.dart';

class BooksViewModel extends ViewModel {
  final Source source;
  var _page = 0;
  var _books = <Book>[];

  String get title => source.name;

  List<Book> get books => _books;

  BooksViewModel(SourceID id) : source = Source.of(id) {
    refresh();
  }

  Future<void> refresh() {
    if (loading) return Future.value();
    loading = true;
    return source
        .fetchBooks(page: 0)
        .then((value) => _books = value)
        .then((_) => notifyListeners())
        .then((_) => _page = 0)
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }

  Future<void> load() {
    if (loading || books.isEmpty) return Future.value();
    loading = true;
    return source
        .fetchBooks(page: _page)
        .then((value) => _books += value)
        .then((_) => notifyListeners())
        .then((_) => _page = _page + 1)
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }
}

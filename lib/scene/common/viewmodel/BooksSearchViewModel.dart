import 'package:flutter/foundation.dart';
import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/source/Source.dart';

class BooksSearchViewModel with ChangeNotifier {
  final Source _source;
  var _query = '';
  var _page = 0;
  var _loading = false;
  var _books = <Book>[];

  bool get loading => _loading;

  void _setLoading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  List<Book> get books => _books;

  BooksSearchViewModel(SourceId sourceId) : _source = Source.of(sourceId);

  Future<void> search(String query) {
    if (loading) return Future.value();
    if (_query != query) {
      _page = 0;
      _books = [];
    }
    _setLoading(true);
    return _source
        .fetchBooks(page: _page, query: query)
        .then((value) => _books += value)
        .then((_) => notifyListeners())
        .then((_) => _page += 1)
        .then((_) => _query = query)
        .whenComplete(() => _setLoading(false));
  }
}

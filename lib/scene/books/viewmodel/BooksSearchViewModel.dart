import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/source/Source.dart';
import 'package:fomic/scene/ViewModel.dart';

class BooksSearchViewModel extends ViewModel {
  final Source _source;
  var _query = '';
  var _page = 0;
  var _books = <Book>[];

  List<Book> get books => _books;

  BooksSearchViewModel(SourceId sourceId) : _source = Source.of(sourceId);

  Future<void> search(String query) {
    if (loading.value) return Future.value();
    if (_query != query) {
      _page = 0;
      _books = [];
    }
    loading.value = true;
    return _source
        .fetchBooks(page: _page, query: query)
        .then((value) => _books += value)
        .then((_) => notifyListeners())
        .then((_) => _page += 1)
        .then((_) => _query = query)
        .whenComplete(() => loading.value = false);
  }
}

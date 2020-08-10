import 'dart:async';

import 'package:fomic/model/constant/repository_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/repository/repository.dart';
import 'package:fomic/scene/view_model.dart';

class BooksViewModel extends ViewModel {
  final Repository repository;
  var _page = 0;
  var _books = <Book>[];

  String get title => repository.id.name;

  List<Book> get books => _books;

  BooksViewModel(RepositoryID repositoryID) : repository = Repository.of(repositoryID);

  Future<void> load() {
    if (loading ?? false) return Future.value();
    loading = true;
    return repository
        .fetchBooks(page: _page)
        .then((value) => _books += value)
        .then((_) => notifyListeners())
        .then((_) => _page = _page + 1)
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }

  Future<void> refresh() {
    if (loading ?? false) return Future.value();
    loading = true;
    return repository
        .fetchBooks(page: 0)
        .then((value) => _books = value)
        .then((_) => notifyListeners())
        .then((_) => _page = 0)
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }

  void favorite() {
    message = 'Added to favorites';
  }
}

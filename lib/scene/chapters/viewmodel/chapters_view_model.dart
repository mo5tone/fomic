import 'package:fomic/model/constant/repository_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/repository/repository.dart';
import 'package:fomic/scene/view_model.dart';

class ChaptersViewModel extends ViewModel {
  final Repository _repository;
  Book _book;
  var _chapters = <Chapter>[];

  Book get book => _book;
  List<Chapter> get chapters => _chapters;

  ChaptersViewModel(RepositoryID repositoryID, Book book)
      : _repository = Repository.of(repositoryID),
        _book = book;

  Future<void> fetch() {
    if (loading) return Future.value();
    loading = true;
    final futureBook = _repository.fetchBook(_book);
    final futureChapters = _repository.fetchChapters(_book);
    return Future.wait<dynamic>([futureBook, futureChapters])
        .then((value) {
          _book = _book.merge(value[0]);
          _chapters = value[1];
        })
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }
}

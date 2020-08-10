import 'package:fomic/model/constant/repository_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/repository/repository.dart';
import 'package:fomic/scene/view_model.dart';

class ChaptersViewModel extends ViewModel {
  final Repository _source;
  Book _book;
  var _chapters = <Chapter>[];

  Book get book => _book;
  List<Chapter> get chapters => _chapters;

  ChaptersViewModel(RepositoryID sourceId, Book book)
      : _source = Repository.of(sourceId),
        _book = book;

  Future<void> fetch() {
    if (loading) return Future.value();
    loading = true;
    final futureBook = _source.fetchBook(_book);
    final futureChapters = _source.fetchChapters(_book);
    return Future.wait<dynamic>([futureBook, futureChapters])
        .then((value) {
          _book = _book.merge(value[0]);
          _chapters = value[1];
          notifyListeners();
        })
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }
}

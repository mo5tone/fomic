import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/source/Source.dart';
import 'package:fomic/scene/ViewModel.dart';

class ChaptersViewModel extends ViewModel {
  final Source _source;
  Book _book;
  var _chapters = <Chapter>[];

  Book get book => _book;
  List<Chapter> get chapters => _chapters;

  ChaptersViewModel(SourceId sourceId, Book book)
      : _source = Source.of(sourceId),
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

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
    if (loading.value) return Future.value();
    loading.value = true;
    final futureBook = _source.fetchBook(_book);
    final futureChapters = _source.fetchChapters(_book);
    return Future.wait<dynamic>([futureBook, futureChapters]).then((value) {
      _book = _book.merge(value[0]);
      _chapters = value[1];
      notifyListeners();
    }).whenComplete(() => loading.value = false);
  }
}

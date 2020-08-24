import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/source/source.dart';
import 'package:fomic/scene/view_model.dart';

class ChaptersViewModel extends ViewModel {
  final Source source;
  Book _book;
  var _chapters = <Chapter>[];

  Book get book => _book;
  List<Chapter> get chapters => _chapters;

  void _setBookAndChapters(List<dynamic> result) {
    if (result[0] is Book && result[1] is List<Chapter>) {
      _book = result[0];
      _chapters = result[1];
      notifyListeners();
    }
  }

  ChaptersViewModel(this.source, Book book) : _book = book {
    fetch();
  }

  Future<void> fetch() {
    if (loading) return Future.value();
    loading = true;
    return Future.wait<dynamic>([source.fetchBook(_book), source.fetchChapters(_book)])
        .then(_setBookAndChapters)
        .catchError((err) => message = err.toString())
        .whenComplete(() => loading = false);
  }

  Future<void> favorite() {
    // TODO: implement favorite
    return Future.value();
  }

  Future<void> download() {
    // TODO: implement download
    return Future.value();
  }
}

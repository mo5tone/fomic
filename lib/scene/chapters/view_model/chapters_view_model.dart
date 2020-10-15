import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/storage/favorite.dart';
import 'package:fomic/model/source/source.dart';
import 'package:fomic/scene/view_model.dart';

class ChaptersViewModel extends ViewModel {
  final Source source;
  Book _book;
  var _chapters = <Chapter>[];
  bool _favorited = false;

  Book get book => _book;

  List<Chapter> get chapters => _chapters;

  bool get favorited => _favorited;

  @protected
  set favorited(bool value) {
    if (value != _favorited) {
      _favorited = value;
      notifyListeners();
    }
  }

  void _setBookAndChapters(List<dynamic> result) {
    if (result[0] is Book && result[1] is List<Chapter>) {
      _book = result[0];
      _chapters = result[1];
      _chapters.sort((c0, c1) => c0.index.compareTo(c1.index));
      notifyListeners();
    }
  }

  ChaptersViewModel(this.source, Book book) : _book = book {
    fetch();
    Favorite.contains(source.id, book).then((value) => favorited = value);
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
    favorited = !favorited;
    return Favorite.next(source.id, book);
  }

  Future<void> download() {
    // TODO: implement download
    return Future.value();
  }
}

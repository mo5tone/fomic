import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';

enum ComicStateType {
  fetching,
  fetchSuccess,
  fetchFailure,
}

class ComicState implements Cloneable {
  final ComicStateType type;
  final Comic comic;
  final List<Chapter> chapters;
  final bool isFavorite;
  final Object error;
  final StackTrace stackTrace;

  DateTime get latestUpdateAt {
    var list = List.of(chapters)
      ..sort((left, right) => left.updateAt.compareTo(right.updateAt));
    try {
      return list.last.updateAt;
    } catch (_) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
  }

  ComicState(
    this.type, {
    this.comic,
    this.chapters = const [],
    this.isFavorite = false,
    this.error,
    this.stackTrace,
  })  : assert(type != null),
        assert(comic != null);

  @override
  clone({
    ComicStateType type,
    Comic comic,
    List<Chapter> chapters,
    bool isFavorite,
    Object error,
    StackTrace stackTrace,
  }) {
    return ComicState(
      type ?? this.type,
      comic: comic ?? this.comic,
      chapters: chapters ?? this.chapters,
      isFavorite: isFavorite ?? this.isFavorite,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

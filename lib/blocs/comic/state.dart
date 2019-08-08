import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';

enum ComicStateType {
  fetching,
  successful,
  failed,
}

class ComicState extends base.State<ComicStateType> {
  final Comic comic;
  final List<Chapter> chapters;
  final Object error;
  final StackTrace stackTrace;

  ComicState(
    ComicStateType type, {
    this.comic,
    this.chapters = const [],
    this.error,
    this.stackTrace,
  })  : assert(comic != null),
        super(type);

  @override
  clone({
    ComicStateType type,
    Comic comic,
    List<Chapter> chapters,
    Object error,
    StackTrace stackTrace,
  }) {
    return ComicState(
      type ?? this.type,
      comic: comic ?? this.comic,
      chapters: chapters ?? this.chapters,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/manga.dart';

enum MangaStateType {
  fetching,
  successful,
  failed,
}

class MangaState extends base.State<MangaStateType> {
  final Manga manga;
  final List<Chapter> chapterList;
  final Object error;
  final StackTrace stackTrace;

  MangaState(
    MangaStateType type, {
    this.manga,
    this.chapterList = const [],
    this.error,
    this.stackTrace,
  })  : assert(manga != null),
        super(type);

  @override
  clone({
    MangaStateType type,
    Manga manga,
    List<Chapter> chapterList,
    Object error,
    StackTrace stackTrace,
  }) {
    return MangaState(
      type ?? this.type,
      manga: manga ?? this.manga,
      chapterList: chapterList ?? this.chapterList,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

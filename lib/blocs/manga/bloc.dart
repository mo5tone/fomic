import 'package:bloc/bloc.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final Manga manga;

  MangaBloc(this.manga);

  @override
  MangaState get initialState => MangaState(
        MangaStateType.successful,
        manga: manga,
      );

  @override
  Stream<MangaState> mapEventToState(MangaEvent event) async* {
    switch (event.type) {
      case MangaEventType.fetch:
        final source = Source.of(manga.sourceId);
        try {
          if (source is OnlineSource) {
            final mangaAndChapterList =
                await source.fetchMangaAndChapterList(this.manga);
            yield currentState.clone(
              type: MangaStateType.successful,
              manga: mangaAndChapterList.$0,
              chapterList: mangaAndChapterList.$1,
            );
          } else if (source is LocalSource) {
            yield currentState.clone();
          }
        } catch (error) {
          yield currentState.clone(
            type: MangaStateType.failed,
            error: error,
          );
        }
        break;
    }
  }
}

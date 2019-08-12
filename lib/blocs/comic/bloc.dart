import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/comic/event.dart';
import 'package:fomic/blocs/comic/state.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final Manga comic;

  ComicBloc(this.comic);

  @override
  ComicState get initialState => ComicState(
        ComicStateType.successful,
        comic: comic,
      );

  @override
  Stream<ComicState> mapEventToState(ComicEvent event) async* {
    switch (event.type) {
      case ComicEventType.fetch:
        final source = Source.of(comic.sourceId);
        try {
          if (source is OnlineSource) {
            final comic = await source.fetchComic(this.comic);
            yield currentState.clone(
              type: ComicStateType.successful,
              comic: comic,
              chapters: comic.chapters.isEmpty
                  ? await source.fetchChapters(comic)
                  : comic.chapters,
            );
          } else if (source is LocalSource) {
            yield currentState.clone();
          }
        } catch (error) {
          yield currentState.clone(
            type: ComicStateType.failed,
            error: error,
          );
        }
        break;
    }
  }
}

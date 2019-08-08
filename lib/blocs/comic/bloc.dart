import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/comic/event.dart';
import 'package:fomic/blocs/comic/state.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/local/source.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final Comic comic;

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
        final source = comic.source;
        try {
          if (source is OnlineSource) {
            final comic = await source.fetchComic(this.comic);
            if (comic.chapters.isEmpty) {
              yield currentState.clone(
                type: ComicStateType.successful,
                comic: comic,
                chapters: await source.fetchChapters(comic),
              );
            } else {
              yield currentState.clone(
                type: ComicStateType.successful,
                comic: comic,
                chapters: comic.chapters,
              );
            }
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

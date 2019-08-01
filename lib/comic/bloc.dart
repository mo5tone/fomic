import 'package:bloc/bloc.dart';
import 'package:fomic/comic/event.dart';
import 'package:fomic/comic/state.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/source/base/remote_source.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final Comic comic;

  RemoteSource get _source => comic.source;

  ComicBloc(this.comic);

  @override
  ComicState get initialState => ComicState(
        ComicStateType.fetchSuccess,
        comic: comic,
      );

  @override
  Stream<ComicState> mapEventToState(ComicEvent event) async* {
    if (event.type == ComicEventType.fetch &&
        (currentState.type == ComicStateType.fetchSuccess ||
            currentState.type == ComicStateType.fetchFailure)) {
      yield currentState.clone(
        type: ComicStateType.fetching,
      );
      try {
        var comic = await _source.fetchComic(this.comic);
        var chapters = await _source.fetchChapters(comic ?? this.comic);
        yield currentState.clone(
          type: ComicStateType.fetchSuccess,
          comic: comic,
          chapters: chapters,
        );
      } catch (error) {
        yield currentState.clone(
          type: ComicStateType.fetchFailure,
          error: error,
        );
      }
    } else if (event.type == ComicEventType.pushToChapterScreen) {
      yield currentState.clone(
        type: ComicStateType.pushToChapterScreen,
        chapter: event.chapter,
      );
    }
  }
}

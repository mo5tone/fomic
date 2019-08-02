import 'package:bloc/bloc.dart';
import 'package:fomic/comic/event.dart';
import 'package:fomic/comic/state.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/source/base/remote_source.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final Comic comic;

  RemoteSource get _source => RemoteSource.of(comic.id);

  ComicBloc(this.comic);

  @override
  ComicState get initialState => ComicState(
        ComicStateType.fetchSuccess,
        comic: comic,
      );

  @override
  Stream<ComicState> mapEventToState(ComicEvent event) async* {
    if (event.type == ComicEventType.fetch &&
        currentState.type != ComicStateType.fetching) {
      yield currentState.clone(
        type: ComicStateType.fetching,
      );
      try {
        final comic = await _source.fetchComic(this.comic);
        yield currentState.clone(
          type: ComicStateType.fetchSuccess,
          comic: comic,
          chapters: comic.chapters.isEmpty
              ? await _source.fetchChapters(comic)
              : comic.chapters,
        );
      } catch (error) {
        yield currentState.clone(
          type: ComicStateType.fetchFailure,
          error: error,
        );
      }
    }
  }
}

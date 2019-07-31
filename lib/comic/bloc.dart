import 'package:bloc/bloc.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/source/base/remote_source.dart';

import 'event.dart';
import 'state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final Comic comic;

  RemoteSource get _source => comic.source;
  List<Chapter> _chapters = [];

  ComicBloc(this.comic);

  @override
  ComicState get initialState => ComicState(
        ComicStateType.fetchSuccess,
        comic: comic,
      );

  @override
  Stream<ComicState> mapEventToState(ComicEvent event) async* {
    if (currentState.type == ComicStateType.fetchSuccess ||
        currentState.type == ComicStateType.fetchFailure) {
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
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:fomic/chapter/event.dart';
import 'package:fomic/chapter/state.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/source/base/remote_source.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  final Chapter chapter;

  RemoteSource get _source => RemoteSource.of(chapter.id);

  ChapterBloc(this.chapter);

  @override
  ChapterState get initialState => ChapterState(ChapterStateType.fetchSuccess);

  @override
  Stream<ChapterState> mapEventToState(ChapterEvent event) async* {
    if (event.type == ChapterEventType.fetch &&
        currentState.type != ChapterStateType.fetching) {
      yield currentState.clone(type: ChapterStateType.fetching);
      try {
        final pages = await _source.fetchPages(chapter);
        yield currentState.clone(
          type: ChapterStateType.fetchSuccess,
          pages: pages,
        );
      } catch (error) {
        yield currentState.clone(
          type: ChapterStateType.fetchFailure,
          error: error,
        );
      }
    }
  }
}

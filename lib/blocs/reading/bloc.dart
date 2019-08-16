import 'package:bloc/bloc.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  final Chapter chapter;

  Source get source => Source.of(chapter.manga.sourceId);

  ReadingBloc(this.chapter);

  @override
  ReadingState get initialState => ReadingState(
        ReadingStateType.successful,
        chapter: chapter,
      );

  @override
  Stream<ReadingState> mapEventToState(ReadingEvent event) async* {
    if (event is ReadingEventFetch) {
      if (currentState.type != ReadingStateType.fetching) {
        yield currentState.clone(type: ReadingStateType.fetching);
        try {
          if (source is OnlineSource) {
            final pageList =
                await (source as OnlineSource).fetchPageList(chapter);
            yield currentState.clone(
              type: ReadingStateType.successful,
              pageList: pageList,
            );
          } else if (source is LocalSource) {
            // todo
          }
        } catch (error) {
          yield currentState.clone(
            type: ReadingStateType.failed,
            error: error,
          );
        }
      }
    } else if (event is ReadingEventToggleOverlay) {
      yield currentState.clone(fullPage: !currentState.fullPage);
    } else if (event is ReadingEventDisplayPage) {
      yield currentState.clone(pageIndex: event.pageIndex);
    }
  }
}

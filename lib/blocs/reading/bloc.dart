import 'package:bloc/bloc.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  final Chapter chapter;

  ReadingBloc(this.chapter);

  @override
  ReadingState get initialState => ReadingState(chapter);

  @override
  Stream<ReadingState> mapEventToState(ReadingEvent event) async* {
    switch (event.runtimeType) {
      case ReadingEventFetch:
        if (currentState.isFetching) {
          return;
        }
        yield currentState.clone(isFetching: true);
        final source = Source.of(chapter.book.sourceId);
        try {
          if (source is OnlineSource) {
            final pageList = await source.fetchPages(chapter);
            yield currentState.clone(pageList: pageList);
          } else if (source is LocalSource) {
            // todo
          }
        } catch (error) {
          yield currentState.clone(error: error);
        }
        break;
      case ReadingEventToggleOverlay:
        yield currentState.clone(isFullPage: !currentState.isFullPage);
        break;
      case ReadingEventDisplayPage:
        yield currentState.clone(pageIndex: event.pageIndex);
        break;
      default:
        break;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  final Chapter chapter;

  ChapterBloc(this.chapter);

  @override
  ChapterState get initialState => ChapterState(chapter);

  @override
  Stream<ChapterState> mapEventToState(ChapterEvent event) async* {
    switch (event.runtimeType) {
      case ChapterEventFetch:
        if (currentState.isFetching) {
          return;
        }
        yield currentState.clone(isFetching: true);
        final source = Source.of(chapter.book.sourceIdentity);
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
      case ChapterEventToggleOverlay:
        yield currentState.clone(isFullPage: !currentState.isFullPage);
        break;
      case ChapterEventDisplayPage:
        yield currentState.clone(pageIndex: event.pageIndex);
        break;
      default:
        break;
    }
  }
}

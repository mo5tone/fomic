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
    switch (event.type) {
      case ReadingEventType.fetch:
        if (source is OnlineSource) {
          final pageList = (source as OnlineSource).fetchPageList(chapter);
        } else if (source is LocalSource) {
          // todo
        }
        break;
      case ReadingEventType.toggleOverlay:
        yield currentState.clone(fullPage: !currentState.fullPage);
        break;
    }
  }
}

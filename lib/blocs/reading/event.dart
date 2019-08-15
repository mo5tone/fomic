import 'package:fomic/blocs/base/event.dart';

enum ReadingEventType {
  fetch,
  toggleOverlay,
  showPage,
}

class ReadingEvent extends Event<ReadingEventType> {
  final int pageIndex;

  ReadingEvent(
    ReadingEventType type, {
    this.pageIndex = 0,
  }) : super(type);
}

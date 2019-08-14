import 'package:fomic/blocs/base/event.dart';

enum ReadingEventType {
  fetch,
  toggleOverlay,
}

class ReadingEvent extends Event<ReadingEventType> {
  ReadingEvent(ReadingEventType type) : super(type);
}

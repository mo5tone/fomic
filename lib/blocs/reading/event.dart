import 'package:fomic/blocs/base/event.dart';

class ReadingEvent extends Event {
  final int pageIndex;

  ReadingEvent._(this.pageIndex);

  factory ReadingEvent.fetch() {
    return ReadingEventFetch._();
  }

  factory ReadingEvent.toggleOverlay() {
    return ReadingEventToggleOverlay._();
  }

  factory ReadingEvent.displayPage(int index) {
    return ReadingEventDisplayPage._(index);
  }
}

class ReadingEventFetch extends ReadingEvent {
  ReadingEventFetch._() : super._(null);
}

class ReadingEventToggleOverlay extends ReadingEvent {
  ReadingEventToggleOverlay._() : super._(null);
}

class ReadingEventDisplayPage extends ReadingEvent {
  ReadingEventDisplayPage._(int pageIndex)
      : assert(pageIndex != null),
        super._(pageIndex);
}

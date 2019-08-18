import 'package:fomic/blocs/base/event.dart';

class ChapterEvent extends Event {
  final int pageIndex;

  ChapterEvent._(this.pageIndex);

  factory ChapterEvent.fetch() {
    return ChapterEventFetch._();
  }

  factory ChapterEvent.toggleOverlay() {
    return ChapterEventToggleOverlay._();
  }

  factory ChapterEvent.displayPage(int index) {
    return ChapterEventDisplayPage._(index);
  }
}

class ChapterEventFetch extends ChapterEvent {
  ChapterEventFetch._() : super._(null);
}

class ChapterEventToggleOverlay extends ChapterEvent {
  ChapterEventToggleOverlay._() : super._(null);
}

class ChapterEventDisplayPage extends ChapterEvent {
  ChapterEventDisplayPage._(int pageIndex)
      : assert(pageIndex != null),
        super._(pageIndex);
}

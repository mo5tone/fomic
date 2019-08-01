import 'package:fomic/model/chapter.dart';

enum ComicEventType { fetch, pushToChapterScreen }

class ComicEvent {
  final ComicEventType type;
  final Chapter chapter;

  ComicEvent(
    this.type, {
    this.chapter,
  }) : assert(type != null) {
    switch (type) {
      case ComicEventType.pushToChapterScreen:
        assert(chapter != null);
        break;
      default:
        break;
    }
  }
}

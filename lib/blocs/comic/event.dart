import 'package:fomic/blocs/base/event.dart' as base;

enum ComicEventType {
  fetch,
}

class ComicEvent extends base.Event<ComicEventType> {
  ComicEvent(ComicEventType type) : super(type);
}

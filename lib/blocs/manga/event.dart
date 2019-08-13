import 'package:fomic/blocs/base/event.dart' as base;

enum MangaEventType {
  fetch,
}

class MangaEvent extends base.Event<MangaEventType> {
  MangaEvent(MangaEventType type) : super(type);
}

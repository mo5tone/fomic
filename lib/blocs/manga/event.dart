import 'package:fomic/blocs/base/event.dart' as base;

class MangaEvent extends base.Event {
  MangaEvent._();

  factory MangaEvent.fetch() {
    return MangaEventFetch._();
  }

  factory MangaEvent.favorite() {
    return MangaEventFavorite._();
  }
}

class MangaEventFetch extends MangaEvent {
  MangaEventFetch._() : super._();
}

class MangaEventFavorite extends MangaEvent {
  MangaEventFavorite._() : super._();
}

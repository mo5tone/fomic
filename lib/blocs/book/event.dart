import 'package:fomic/blocs/base/event.dart' as base;

class BookEvent extends base.Event {
  BookEvent._();

  factory BookEvent.fetch() {
    return BookEventFetch._();
  }

  factory BookEvent.favorite() {
    return BookEventFavorite._();
  }
}

class BookEventFetch extends BookEvent {
  BookEventFetch._() : super._();
}

class BookEventFavorite extends BookEvent {
  BookEventFavorite._() : super._();
}

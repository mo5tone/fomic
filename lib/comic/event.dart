enum ComicEventType {
  fetch,
}

class ComicEvent {
  final ComicEventType type;

  ComicEvent(this.type) : assert(type != null);
}

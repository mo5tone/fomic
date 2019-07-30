import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';

enum ComicsEventType {
  refresh,
  loadMore,
  pushToComicScreen,
  pushToSearchScreen
}

class ComicsEvent {
  final ComicsEventType type;
  final String query;
  final List<Filter> filters;
  final Comic comic;

  ComicsEvent(
    this.type, {
    this.query = '',
    this.filters = const [],
    this.comic,
  }) : assert(type != null) {
    switch (type) {
      case ComicsEventType.pushToComicScreen:
        assert(comic != null);
        break;
      default:
        break;
    }
  }
}

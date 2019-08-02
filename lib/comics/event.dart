import 'package:fomic/model/filter.dart';

enum ComicsEventType {
  refresh,
  loadMore,
}

class ComicsEvent {
  final ComicsEventType type;
  final String query;
  final List<Filter> filters;

  ComicsEvent(
    this.type, {
    this.query = '',
    this.filters = const [],
  }) : assert(type != null);
}

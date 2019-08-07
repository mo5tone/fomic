import 'package:fomic/blocs/base/event.dart' as base;
import 'package:fomic/model/filter.dart';

enum SourceEventType {
  fetch,
  more,
  startSearching,
  endSearching,
}

class SourceEvent extends base.Event<SourceEventType> {
  final String query;
  final List<Filter> filters;

  SourceEvent(
    SourceEventType type, {
    this.query = '',
    this.filters = const [],
  }) : super(type);
}

import 'package:fomic/blocs/base/event.dart' as base;
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';

enum SourcesEventType {
  fetch,
  more,
  displaySource,
  enableSource,
  disableSource,
  beginSearching,
  endSearching,
}

class SourcesEvent extends base.Event<SourcesEventType> {
  final SourceId sourceId;
  final String query;
  final List<Filter> filters;

  SourcesEvent(
    SourcesEventType type, {
    this.sourceId,
    this.query = '',
    this.filters = const [],
  }) : super(type);
}

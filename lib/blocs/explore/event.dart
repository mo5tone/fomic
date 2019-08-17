import 'package:fomic/blocs/base/event.dart' as base;
import 'package:fomic/sources/base/source.dart';

class SourcesEvent extends base.Event {
  final SourceId sourceId;
  final String query;

  SourcesEvent._(this.sourceId, this.query);

  factory SourcesEvent.fetch({String query = ''}) {
    return SourcesEventFetch._(query);
  }

  factory SourcesEvent.more() {
    return SourcesEventMore._();
  }

  factory SourcesEvent.displaySource(SourceId sourceId) {
    return SourcesEventDisplaySource._(sourceId);
  }

  factory SourcesEvent.toggleSource(SourceId sourceId) {
    return SourcesEventToggleSource._(sourceId);
  }

  factory SourcesEvent.toggleSearching() {
    return SourcesEventToggleSearching._();
  }
}

class SourcesEventFetch extends SourcesEvent {
  SourcesEventFetch._(String query) : super._(null, query ?? '');
}

class SourcesEventMore extends SourcesEvent {
  SourcesEventMore._() : super._(null, '');
}

class SourcesEventDisplaySource extends SourcesEvent {
  SourcesEventDisplaySource._(SourceId sourceId) : super._(sourceId, '');
}

class SourcesEventToggleSource extends SourcesEvent {
  SourcesEventToggleSource._(SourceId sourceId) : super._(sourceId, null);
}

class SourcesEventToggleSearching extends SourcesEvent {
  SourcesEventToggleSearching._() : super._(null, null);
}

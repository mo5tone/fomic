import 'package:fomic/blocs/base/event.dart' as base;
import 'package:fomic/sources/base/source.dart';

class SourcesEvent extends base.Event {
  final SourceIdentity sourceId;
  final String query;

  SourcesEvent._(this.sourceId, this.query);

  factory SourcesEvent.fetch({String query = ''}) {
    return SourcesEventFetch._(query);
  }

  factory SourcesEvent.more() {
    return SourcesEventMore._();
  }

  factory SourcesEvent.displaySource(SourceIdentity sourceId) {
    return SourcesEventDisplaySource._(sourceId);
  }

  factory SourcesEvent.toggleSource(SourceIdentity sourceId) {
    return SourcesEventToggleSource._(sourceId);
  }

  factory SourcesEvent.toggleSearchMode() {
    return SourcesEventToggleSearchMode._();
  }
}

class SourcesEventFetch extends SourcesEvent {
  SourcesEventFetch._(String query) : super._(null, query ?? '');
}

class SourcesEventMore extends SourcesEvent {
  SourcesEventMore._() : super._(null, '');
}

class SourcesEventDisplaySource extends SourcesEvent {
  SourcesEventDisplaySource._(SourceIdentity sourceId) : super._(sourceId, '');
}

class SourcesEventToggleSource extends SourcesEvent {
  SourcesEventToggleSource._(SourceIdentity sourceId) : super._(sourceId, null);
}

class SourcesEventToggleSearchMode extends SourcesEvent {
  SourcesEventToggleSearchMode._() : super._(null, null);
}

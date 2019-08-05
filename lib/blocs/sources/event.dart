import 'package:fomic/blocs/base/event.dart' as base;
import 'package:fomic/sources/base/source.dart';

enum SourcesEventType {
  initSources,
  switchSourceState,
}

class SourcesEvent extends base.Event<SourcesEventType> {
  final SourceId sourceId;

  SourcesEvent(SourcesEventType type, {this.sourceId}) : super(type);
}

import 'package:fomic/sources/base/source.dart';

enum SourcesEventType {
  init,
  switchSource,
  getAbleToSearch,
  getUnableToSearch,
  search,
}

class SourcesEvent {
  final SourcesEventType type;
  final SourceId sourceId;
  final String query;

  SourcesEvent(
    this.type, {
    this.sourceId,
    this.query,
  }) : assert(type != null);
}

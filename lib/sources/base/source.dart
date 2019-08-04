import 'package:fomic/model/filter.dart';

enum SourceId {
  local,
  dmzj,
  manhuaren,
}

abstract class Source {
  SourceId get id;

  String get name;

  List<Filter> get availableFilters;
}

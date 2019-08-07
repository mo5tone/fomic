import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/dmzj/source.dart';
import 'package:fomic/sources/local/source.dart';
import 'package:fomic/sources/manhuaren/source.dart';

enum SourceId {
  local,
  dmzj,
  manhuaren,
}

abstract class Source {
  SourceId get id;

  String get name;

  bool _available = true;

  bool get available => _available;

  List<Filter> get filters;

  Source();

  factory Source.of(SourceId id) {
    Source source;
    switch (id) {
      case SourceId.local:
        source = LocalSource();
        break;
      case SourceId.dmzj:
        source = Dmzj();
        break;
      case SourceId.manhuaren:
        source = Manhuaren();
        break;
    }
    return source;
  }

  void resetFilter() {
    filters.forEach((filter) {
      if (filter.state is int) {
        filter.state = 0;
      } else if (filter.state is bool) {
        filter.state = false;
      }
    });
  }

  void enable() {
    if (_available != true) {
      _available = true;
    }
  }

  void disable() {
    if (_available != false) {
      _available = false;
    }
  }
}

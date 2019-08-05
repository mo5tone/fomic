import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';

enum SourceStateType {
  fetching,
  fetchSuccess,
  fetchFailure,
}

class SourceState extends base.State<SourceStateType> {
  final Source source;
  final bool isSearching;
  final String query;
  final List<Filter> filters;
  final List<Comic> comics;
  final Object error;
  final StackTrace stackTrace;

  SourceState(
    SourceStateType type, {
    this.source,
    this.isSearching = false,
    this.query = '',
    this.filters = const [],
    this.comics = const [],
    this.error,
    this.stackTrace,
  })  : assert(source != null),
        super(type);

  @override
  clone({
    SourceStateType type,
    bool isSearchable,
    String query,
    List<Filter> filters,
    List<Comic> comics,
    Object error,
    StackTrace stackTrace,
  }) {
    return SourceState(
      type ?? this.type,
      source: this.source,
      isSearching: isSearchable ?? this.isSearching,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      comics: comics ?? this.comics,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

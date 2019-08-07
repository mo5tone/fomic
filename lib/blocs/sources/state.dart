import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';

enum SourcesStateType {
  fetching,
  successful,
  failed,
}

class SourcesState extends base.State<SourcesStateType> {
  final SourceId sourceId;
  final int page;
  final String query;
  final List<Filter> filters;
  final List<Comic> comics;
  final Object error;
  final StackTrace stackTrace;

  SourcesState(
    SourcesStateType type, {
    this.sourceId,
    this.page = 0,
    this.query = '',
    this.filters = const [],
    this.comics = const [],
    this.error,
    this.stackTrace,
  })  : assert(sourceId != null),
        super(type);

  List<Source> get sources => SourceId.values
      .map((id) => Source.of(id))
      .where((source) => source != null)
      .toList(growable: false);

  @override
  clone({
    SourcesStateType type,
    SourceId sourceId,
    int page,
    String query,
    List<Filter> filters,
    List<Comic> comics,
    Object error,
    StackTrace stackTrace,
  }) {
    return SourcesState(
      type ?? this.type,
      sourceId: sourceId ?? this.sourceId,
      page: page ?? this.page,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      comics: comics ?? this.comics,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

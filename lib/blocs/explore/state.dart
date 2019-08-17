import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/book.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';

enum SourcesStateType {
  fetching,
  successful,
  failed,
}

class SourcesState extends base.State<SourcesStateType> {
  final SourceId sourceId;
  final bool searching;
  final String query;
  final List<Book> books;
  final Object error;
  final StackTrace stackTrace;

  List<Filter> _filters;

  List<Filter> get filters {
    if (_filters == null) {
      _filters = List.from(Source.of(sourceId).filters);
    }
    return _filters;
  }

  SourcesState(
    SourcesStateType type, {
    this.sourceId,
    this.searching = false,
    this.query = '',
    this.books = const [],
    this.error,
    this.stackTrace,
  })  : assert(sourceId != null),
        super(type);

  @override
  clone({
    SourcesStateType type,
    SourceId sourceId,
    bool searching,
    String query,
    List<Book> books,
    Object error,
    StackTrace stackTrace,
  }) {
    return SourcesState(
      type ?? this.type,
      sourceId: sourceId ?? this.sourceId,
      searching: searching ?? this.searching,
      query: query ?? this.query,
      books: books ?? this.books,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    ).._filters = filters;
  }
}

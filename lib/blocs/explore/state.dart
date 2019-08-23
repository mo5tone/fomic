import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/book.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';

class SourcesState extends base.State<SourcesState> {
  final SourceIdentity sourceId;
  bool isFetching = false;
  bool isSearchMode = false;
  String query = '';
  List<Filter> _filters;
  List<Book> books = [];
  Object error;
  StackTrace stackTrace;

  List<Filter> get filters {
    if (_filters == null) {
      _filters = List.from(Source.of(sourceId).filters);
    }
    return _filters;
  }

  SourcesState(this.sourceId) : assert(sourceId != null);

  @override
  SourcesState clone({
    SourceIdentity sourceId,
    bool isFetching,
    bool isSearchMode,
    String query,
    List<Book> books,
    Object error,
    StackTrace stackTrace,
  }) {
    return SourcesState(sourceId ?? this.sourceId)
      ..isFetching = isFetching ?? false
      ..isSearchMode = isSearchMode ?? this.isSearchMode
      ..query = query ?? this.query
      ..books = books ?? this.books
      ..error = error
      ..stackTrace = stackTrace
      .._filters = filters;
  }
}

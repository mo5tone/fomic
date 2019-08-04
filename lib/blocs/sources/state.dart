import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/comic.dart';
import 'package:fomic/sources/base/source.dart';

enum SourcesStateType {
  unableToSearch,
  ableToSearch,
  searching,
  searchSuccess,
  searchFailure,
}

class SourcesState extends base.State {
  final bool isSearchable;
  final String query;
  final List<Comic> comics;
  final Object error;
  final StackTrace stackTrace;

  SourcesState(
    SourcesStateType type, {
    this.isSearchable = false,
    this.query = '',
    this.comics = const [],
    this.error,
    this.stackTrace,
  }) : super(type);

  List<Source> get sources => SourceId.values
      .map((id) => Source.of(id))
      .where((source) => source != null)
      .toList(growable: false);

  @override
  clone({
    SourcesStateType type,
    bool isSearchable,
    String query,
    List<Comic> comics,
    Object error,
    StackTrace stackTrace,
  }) {
    return SourcesState(
      type ?? this.type,
      isSearchable: isSearchable ?? this.isSearchable,
      query: query ?? this.query,
      comics: comics ?? this.comics,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

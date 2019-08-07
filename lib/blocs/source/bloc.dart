import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/source/event.dart';
import 'package:fomic/blocs/source/state.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  final Source source;
  int _page = 0;

  SourceBloc(this.source);

  @override
  SourceState get initialState => SourceState(
        SourceStateType.fetchSuccess,
        source: source,
      );

  @override
  Stream<SourceState> mapEventToState(SourceEvent event) async* {
    switch (event.type) {
      case SourceEventType.fetch:
        if (currentState.type != SourceStateType.fetching) {
          final source = this.source;
          _page = 0;
          if (source is OnlineSource) {
            yield currentState.clone(type: SourceStateType.fetching);
            try {
              final comics = await source
                  .fetchComics(page: _page, query: event.query)
                  .then((comics) => comics
                      .where((comic) => comic != null)
                      .toList(growable: false));
              yield currentState.clone(
                type: SourceStateType.fetchSuccess,
                query: event.query,
                filters: event.filters,
                comics: comics,
              );
            } catch (error) {
              yield currentState.clone(
                type: SourceStateType.fetchFailure,
                query: event.query,
                filters: event.filters,
                error: error,
              );
            }
          } else if (source is LocalSource) {
            // todo: impl. for LocalSource
          }
        }
        break;
      case SourceEventType.more:
        if (currentState.type != SourceStateType.fetching) {
          final source = this.source;
          _page++;
          if (source is OnlineSource) {
            yield currentState.clone(type: SourceStateType.fetching);
            try {
              final comics = await source
                  .fetchComics(page: _page, query: event.query)
                  .then((comics) => comics
                      .where((comic) => comic != null)
                      .toList(growable: false));
              yield currentState.clone(
                type: SourceStateType.fetchSuccess,
                comics: [
                  ...currentState.comics,
                  ...comics,
                ],
              );
            } catch (error) {
              yield currentState.clone(
                type: SourceStateType.fetchFailure,
                error: error,
              );
            }
          } else if (source is LocalSource) {
            // todo: impl. for LocalSource
          }
        }
        break;
      case SourceEventType.startSearching:
        yield currentState.clone(isSearchable: true);
        break;
      case SourceEventType.endSearching:
        yield currentState.clone(isSearchable: false);
        break;
    }
  }
}

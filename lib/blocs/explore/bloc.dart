import 'package:bloc/bloc.dart';
import 'package:fomic/common/util/key_value_store.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class SourcesBloc extends Bloc<SourcesEvent, SourcesState> {
  var _page = 0;

  SourcesBloc() : super() {
    SourceId.values.forEach((id) {
      final source = Source.of(id);
      KeyValue.sourceIsAvailable(id).then((available) {
        if (available) {
          source.enable();
        } else {
          source.disable();
        }
      });
    });
  }

  @override
  SourcesState get initialState => SourcesState(
        SourcesStateType.successful,
        sourceId: SourceId.values.first,
      );

  @override
  Stream<SourcesState> mapEventToState(SourcesEvent event) async* {
    if (event is SourcesEventToggleSearching) {
      yield currentState.clone(searching: !currentState.searching);
    } else if (event is SourcesEventToggleSource) {
      final source = Source.of(event.sourceId);
      if (source.available) {
        KeyValue.disableSource(event.sourceId);
        Source.of(event.sourceId).disable();
      } else {
        KeyValue.enableSource(event.sourceId);
        Source.of(event.sourceId).enable();
      }
      yield currentState.clone();
    } else if (event is SourcesEventDisplaySource ||
        event is SourcesEventFetch ||
        event is SourcesEventMore) {
      if (event is SourcesEventDisplaySource) {
        yield SourcesState(
          SourcesStateType.successful,
          sourceId: event.sourceId,
        );
      }
      _page = event is SourcesEventMore ? _page + 1 : 0;
      if (currentState.type == SourcesStateType.fetching) {
        return;
      }
      yield currentState.clone(type: SourcesStateType.fetching);
      final source = Source.of(currentState.sourceId);
      try {
        if (source is OnlineSource) {
          final books = await source
              .fetchBooks(
                  page: _page,
                  query: event.query,
                  filters: currentState.filters)
              .then((books) =>
                  books.where((book) => book != null).toList(growable: false));
          yield currentState.clone(
            type: SourcesStateType.successful,
            query: event.query,
            books: [
              if (_page > 0) ...currentState.books,
              ...books,
            ],
          );
        } else if (source is LocalSource) {
          // todo: local source
          yield currentState.clone(
            type: SourcesStateType.successful,
            query: event.query,
            books: [],
          );
        }
      } catch (error) {
        if (_page > 0) {
          _page--;
        }
        yield currentState.clone(
          type: SourcesStateType.failed,
          query: event.query,
          error: error,
        );
      }
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:fomic/common/util/key_value.dart';
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
  SourcesState get initialState => SourcesState(SourceId.values.first);

  @override
  Stream<SourcesState> mapEventToState(SourcesEvent event) async* {
    switch (event.runtimeType) {
      case SourcesEventToggleSearchMode:
        yield currentState.clone(isSearchMode: !currentState.isSearchMode);
        break;
      case SourcesEventToggleSource:
        final source = Source.of(event.sourceId);
        if (source.available) {
          KeyValue.disableSource(event.sourceId);
          Source.of(event.sourceId).disable();
        } else {
          KeyValue.enableSource(event.sourceId);
          Source.of(event.sourceId).enable();
        }
        yield currentState.clone();
        break;
      case SourcesEventDisplaySource:
        yield SourcesState(event.sourceId);
        continue fetch;
      fetch:
      case SourcesEventFetch:
        continue more;
      more:
      case SourcesEventMore:
        _page = event is SourcesEventMore ? _page + 1 : 0;
        if (currentState.isFetching) {
          return;
        }
        yield currentState.clone(isFetching: true);
        final source = Source.of(currentState.sourceId);
        try {
          if (source is OnlineSource) {
            final books = await source
                .fetchBooks(
                  page: _page,
                  query: event.query,
                  filters: currentState.filters,
                )
                .then((books) => books.where((book) => book != null).toList());
            yield currentState.clone(
              query: event.query,
              books: [
                if (_page > 0) ...currentState.books,
                ...books,
              ],
            );
          } else if (source is LocalSource) {
            // todo: local source
            yield currentState.clone(
              query: event.query,
              books: [],
            );
          }
        } catch (error) {
          if (_page > 0) {
            _page--;
          }
          yield currentState.clone(
            query: event.query,
            error: error,
          );
        }
        break;
      default:
        break;
    }
  }
}

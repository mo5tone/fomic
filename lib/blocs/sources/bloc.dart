import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/sources/event.dart';
import 'package:fomic/blocs/sources/state.dart';
import 'package:fomic/common/util/key_value_store.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

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
    switch (event.type) {
      case SourcesEventType.beginSearching:
        yield currentState.clone(searching: true);
        break;
      case SourcesEventType.endSearching:
        yield currentState.clone(searching: false);
        break;
      case SourcesEventType.enableSource:
        KeyValue.enableSource(event.sourceId);
        Source.of(event.sourceId).enable();
        yield currentState.clone();
        break;
      case SourcesEventType.disableSource:
        KeyValue.disableSource(event.sourceId);
        Source.of(event.sourceId).disable();
        yield currentState.clone();
        break;
      case SourcesEventType.displaySource:
        yield SourcesState(
          SourcesStateType.successful,
          sourceId: event.sourceId,
        );
        continue fetch;
      fetch:
      case SourcesEventType.fetch:
        continue more;
      more:
      case SourcesEventType.more:
        if (currentState.type != SourcesStateType.fetching) {
          yield currentState.clone(type: SourcesStateType.fetching);
          _page = event.type == SourcesEventType.more ? _page + 1 : 0;
          final source = Source.of(currentState.sourceId);
          try {
            if (source is OnlineSource) {
              var comics = await source.fetchComics(
                page: _page,
                query: event.query,
                filters: event.filters,
              );
              comics = comics
                  .where((comics) => comics != null)
                  .toList(growable: false);
              yield currentState.clone(
                type: SourcesStateType.successful,
                query: event.query,
                comics: [
                  if (_page > 0) ...currentState.comics,
                  ...comics,
                ],
              );
            } else if (source is LocalSource) {
              // todo: local source
              yield currentState.clone(
                type: SourcesStateType.successful,
                query: event.query,
                comics: [],
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
        break;
    }
  }
}

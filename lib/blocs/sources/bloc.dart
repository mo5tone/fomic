import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/sources/event.dart';
import 'package:fomic/blocs/sources/state.dart';
import 'package:fomic/common/util/key_value_store.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

class SourcesBloc extends Bloc<SourcesEvent, SourcesState> {
  @override
  SourcesState get initialState => SourcesState(
        SourcesStateType.successful,
        sourceId: SourceId.values.first,
      );

  @override
  Stream<SourcesState> mapEventToState(SourcesEvent event) async* {
    switch (event.type) {
      case SourcesEventType.init:
        SourceId.values.forEach((id) async {
          final source = Source.of(id);
          if (await KeyValue.sourceIsAvailable(id)) {
            source.enable();
          } else {
            source.disable();
          }
        });
        yield currentState.clone();
        break;
      case SourcesEventType.enableSource:
        await KeyValue.enableSource(event.sourceId);
        Source.of(event.sourceId).enable();
        yield currentState.clone();
        break;
      case SourcesEventType.disableSource:
        await KeyValue.disableSource(event.sourceId);
        Source.of(event.sourceId).disable();
        yield currentState.clone();
        break;
      case SourcesEventType.displaySource:
        if (event.sourceId != currentState.sourceId) {
          yield SourcesState(
            SourcesStateType.fetching,
            sourceId: event.sourceId,
          );
          final source = Source.of(event.sourceId);
          if (source is OnlineSource) {
            try {
              List<Comic> comics = await source.fetchComics();
              yield currentState.clone(
                type: SourcesStateType.successful,
                comics: comics,
              );
            } catch (error) {
              yield currentState.clone(
                type: SourcesStateType.failed,
                error: error,
              );
            }
          } else if (source is LocalSource) {
            // todo: local source
          }
        }
        break;
      case SourcesEventType.fetch:
        break;
      case SourcesEventType.clearFilters:
        break;
    }
  }
}

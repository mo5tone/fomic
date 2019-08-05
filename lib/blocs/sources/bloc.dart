import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/sources/event.dart';
import 'package:fomic/blocs/sources/state.dart';
import 'package:fomic/common/util/key_value_store.dart';
import 'package:fomic/sources/base/source.dart';

class SourcesBloc extends Bloc<SourcesEvent, SourcesState> {
  @override
  SourcesState get initialState => SourcesState(SourcesStateType.stateSwitched);

  @override
  Stream<SourcesState> mapEventToState(SourcesEvent event) async* {
    switch (event.type) {
      case SourcesEventType.initSources:
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
      case SourcesEventType.switchSourceState:
        if (event.sourceId != null) {
          final source = Source.of(event.sourceId);
          if (source.available) {
            await KeyValue.disableSource(event.sourceId);
            source.disable();
          } else {
            await KeyValue.enableSource(event.sourceId);
            source.enable();
          }
          yield currentState.clone();
        }
        break;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:fomic/app/event.dart';
import 'package:fomic/app/state.dart';

class FomicBloc extends Bloc<FomicEvent, FomicState> {
  @override
  FomicState get initialState => FomicState();

  @override
  Stream<FomicState> mapEventToState(FomicEvent event) async* {
    yield FomicState(darkMode: !currentState.darkMode);
  }
}

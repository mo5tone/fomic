import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/home/event.dart';
import 'package:fomic/blocs/home/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState(HomeStateType.displaying);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event.type == HomeEventType.display) {
      if (currentState.index != event.index) {
        yield currentState.clone(
          index: event.index,
        );
      }
    }
  }
}

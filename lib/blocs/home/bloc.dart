import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState(HomeStateType.displaying);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.type) {
      case HomeEventType.display:
        if (currentState.index != event.index) {
          yield currentState.clone(
            index: event.index,
          );
        }
        break;
    }
  }
}

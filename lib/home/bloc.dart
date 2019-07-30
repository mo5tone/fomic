import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeStateComics();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEvent2Comics) {
      yield HomeStateComics();
    } else if (event is HomeEvent2Favorite) {
      yield HomeStateFavorite();
    } else if (event is HomeEvent2Download) {
      yield HomeStateDownload();
    } else if (event is HomeEvent2Setting) {
      yield HomeStateSetting();
    }
  }
}

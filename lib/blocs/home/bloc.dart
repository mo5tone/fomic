import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/home/event.dart';
import 'package:fomic/blocs/home/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState(HomeStateType.comicsPage);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.type) {
      case HomeEventType.showComicsPage:
        yield currentState.clone(type: HomeStateType.comicsPage);
        break;
      case HomeEventType.showSourcesPage:
        yield currentState.clone(type: HomeStateType.sourcesPage);
        break;
      case HomeEventType.showDownloadsPage:
        yield currentState.clone(type: HomeStateType.downloadsPage);
        break;
      case HomeEventType.showSettingsPage:
        yield currentState.clone(type: HomeStateType.settingsPage);
        break;
    }
  }
}

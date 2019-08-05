import 'package:fomic/blocs/base/state.dart' as base;

enum HomeStateType {
  comicsPage,
  sourcesPage,
  downloadsPage,
  settingsPage,
}

class HomeState extends base.State<HomeStateType> {
  HomeState(HomeStateType type) : super(type);

  @override
  clone({HomeStateType type}) {
    return HomeState(type ?? this.type);
  }
}

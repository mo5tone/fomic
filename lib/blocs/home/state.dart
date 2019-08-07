import 'package:fomic/blocs/base/state.dart' as base;

enum HomeStateType {
  displaying,
}

class HomeState extends base.State<HomeStateType> {
  final int index;

  HomeState(HomeStateType type, {this.index = 0}) : super(type);

  @override
  clone({HomeStateType type, int index}) {
    return HomeState(
      type ?? this.type,
      index: index ?? this.index,
    );
  }
}

import 'package:fomic/blocs/base/state.dart' as base;

class HomeState extends base.State<HomeState> {
  final int index;

  HomeState({this.index = 0}) : assert(index != null);

  @override
  HomeState clone({int index}) => HomeState(index: index ?? this.index);
}

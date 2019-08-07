import 'package:fomic/blocs/base/event.dart' as base;

enum HomeEventType {
  display,
}

class HomeEvent extends base.Event<HomeEventType> {
  final int index;

  HomeEvent(HomeEventType type, {this.index = 0}) : super(type);
}

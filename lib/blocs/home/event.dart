import 'package:fomic/blocs/base/event.dart' as base;

class HomeEvent extends base.Event {
  final int index;

  HomeEvent._(this.index) : assert(index != null);

  factory HomeEvent.display({int index = 0}) {
    return HomeEventDisplay._(index);
  }
}

class HomeEventDisplay extends HomeEvent {
  HomeEventDisplay._(int index) : super._(index);
}

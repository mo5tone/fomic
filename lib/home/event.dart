abstract class HomeEvent {
  HomeEvent();

  factory HomeEvent.index(int index) {
    switch (index) {
      case 1:
        return HomeEvent2Favorite();
      case 2:
        return HomeEvent2Download();
      case 3:
        return HomeEvent2Setting();
      default:
        return HomeEvent2Comics();
    }
  }
}

class HomeEvent2Comics extends HomeEvent {}

class HomeEvent2Favorite extends HomeEvent {}

class HomeEvent2Download extends HomeEvent {}

class HomeEvent2Setting extends HomeEvent {}

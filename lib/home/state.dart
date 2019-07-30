abstract class HomeState {
  int get index;

  String get title;
}

class HomeStateComics extends HomeState {
  @override
  int get index => 0;

  @override
  String get title => 'Comics';
}

class HomeStateFavorite extends HomeState {
  @override
  int get index => 1;

  @override
  String get title => 'Favorite';
}

class HomeStateDownload extends HomeState {
  @override
  int get index => 2;

  @override
  String get title => 'Download';
}

class HomeStateSetting extends HomeState {
  @override
  int get index => 3;

  @override
  String get title => 'Setting';
}

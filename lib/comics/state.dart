import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/comic.dart';

enum ComicsStateType {
  fetching,
  fetchSuccess,
  fetchFailure,
  pushToComicScreen,
  pushToSearchScreen
}

class ComicsState implements Cloneable {
  final ComicsStateType type;
  final List<Comic> comics;
  final Object error;
  final StackTrace stackTrace;
  final Comic comic;

  ComicsState(
    this.type, {
    this.comics = const [],
    this.error,
    this.stackTrace,
    this.comic,
  })  : assert(type != null),
        assert(comics != null) {
    switch (type) {
      case ComicsStateType.fetchFailure:
        assert(error != null);
        break;
      case ComicsStateType.pushToComicScreen:
        assert(comic != null);
        break;
      default:
        break;
    }
  }

  @override
  clone({
    ComicsStateType type,
    List<Comic> comics,
    Object error,
    StackTrace stackTrace,
    Comic comic,
  }) {
    return ComicsState(
      type ?? this.type,
      comics: comics ?? this.comics,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      comic: comic ?? this.comic,
    );
  }
}

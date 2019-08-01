import 'package:bloc/bloc.dart';
import 'package:fomic/comics/event.dart';
import 'package:fomic/comics/repository.dart';
import 'package:fomic/comics/state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicsRepository repository = ComicsRepository();
  var _page = 0;

  @override
  ComicsState get initialState => ComicsState(ComicsStateType.fetchSuccess);

  @override
  Stream<ComicsState> mapEventToState(ComicsEvent event) async* {
    switch (event.type) {
      case ComicsEventType.refresh:
        _page = 0;
        break;
      case ComicsEventType.loadMore:
        _page++;
        break;
      case ComicsEventType.pushToComicScreen:
        yield currentState.clone(
          type: ComicsStateType.pushToComicScreen,
          comic: event.comic,
        );
        break;
      case ComicsEventType.pushToSearchScreen:
        yield currentState.clone(
          type: ComicsStateType.pushToSearchScreen,
        );
        break;
    }
    if (currentState.type == ComicsStateType.fetchSuccess ||
        currentState.type == ComicsStateType.fetchFailure) {
      yield currentState.clone(
        type: ComicsStateType.fetching,
      );
      try {
        var comics = [
          if (_page > 0) ...currentState.comics,
          ...await repository.fetchComics(
            page: _page,
            query: event.query,
            filters: event.filters,
          ),
        ];
        yield currentState.clone(
          type: ComicsStateType.fetchSuccess,
          comics:
              comics.where((comic) => comic != null).toList(growable: false),
        );
      } catch (error) {
        yield currentState.clone(
          type: ComicsStateType.fetchFailure,
          error: error,
        );
      }
    }
  }
}
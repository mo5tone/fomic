import 'package:bloc/bloc.dart';
import 'package:fomic/comics/event.dart';
import 'package:fomic/comics/state.dart';
import 'package:fomic/repository/comics_repository.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicsRepository repository = ComicsRepository();
  var _page = 0;

  @override
  ComicsState get initialState => ComicsState(ComicsStateType.fetchSuccess);

  @override
  Stream<ComicsState> mapEventToState(ComicsEvent event) async* {
    if ((event.type == ComicsEventType.refresh ||
            event.type == ComicsEventType.loadMore) &&
        currentState.type != ComicsStateType.fetching) {
      if (event.type == ComicsEventType.refresh) {
        _page = 0;
      } else if (event.type == ComicsEventType.loadMore) {
        _page++;
      }
      yield currentState.clone(
        type: ComicsStateType.fetching,
      );
      try {
        final comics = [
          if (_page > 0) ...currentState.comics,
          ...await repository.fetchComics(
            page: _page,
            query: event.query,
            filters: event.filters,
          ),
        ].where((comic) => comic != null).toList(growable: false);
        yield currentState.clone(
          type: ComicsStateType.fetchSuccess,
          comics: comics,
        );
      } catch (error) {
        _page--;
        yield currentState.clone(
          type: ComicsStateType.fetchFailure,
          error: error,
        );
      }
    }
  }
}

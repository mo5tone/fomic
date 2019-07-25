import 'package:bloc/bloc.dart';
import 'package:fomic/model/comic.dart';

import 'event.dart';
import 'repository.dart';
import 'state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicsRepository repository;
  var _page = 0;
  var _comics = <Comic>[];

  ComicsBloc(this.repository);

  @override
  ComicsState get initialState => ComicsStateFetchSuccess([]);

  @override
  Stream<ComicsState> mapEventToState(ComicsEvent event) async* {
    if (currentState is! ComicsStateFetching) {
      yield ComicsStateFetching(_comics);
      try {
        var comics = <Comic>[];
        if (event is ComicsEventRefresh) {
          _page = 0;
          comics = await repository.fetchComics(
              page: _page, query: event.query, filters: event.filters);
        } else if (event is ComicsEventLoadMore) {
          _page++;
          comics = await repository.fetchComics(
              page: _page, query: event.query, filters: event.filters);
          comics = [..._comics, ...comics];
        }
        _comics = comics.where((comic) => comic != null).toList();
        yield ComicsStateFetchSuccess(_comics);
      } catch (error) {
        yield ComicsStateFetchFailure(error, comics: _comics);
      }
    }
  }
}

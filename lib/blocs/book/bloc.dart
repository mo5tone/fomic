import 'package:bloc/bloc.dart';
import 'package:fomic/persistence/database.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final Book book;

  BookBloc(this.book);

  @override
  BookState get initialState => BookState(book);

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    switch (event.runtimeType) {
      case BookEventFetch:
        if (currentState.isFetching) {
          return;
        }
        yield currentState.clone(isFetching: true);
        final source = Source.of(book.sourceIdentity);
        try {
          if (source is OnlineSource) {
            final bookAndChapters =
                await source.fetchBookAndChapters(this.book);
            yield currentState.clone(
              book: bookAndChapters.$0,
              chapterList: bookAndChapters.$1,
            );
          } else if (source is LocalSource) {
            // todo
          }
        } catch (error) {
          yield currentState.clone(error: error);
        }
        break;
      case BookEventFavorite:
        // todo
        break;
      default:
        break;
    }
  }
}

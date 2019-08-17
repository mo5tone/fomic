import 'package:bloc/bloc.dart';
import 'package:fomic/model/book.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/source.dart';

import 'event.dart';
import 'state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final Book book;

  BookBloc(this.book);

  @override
  BookState get initialState => BookState(
        BookStateType.successful,
        book: book,
      );

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if (event is BookEventFetch) {
      final source = Source.of(book.sourceId);
      try {
        if (source is OnlineSource) {
          final bookAndChapters = await source.fetchBookAndChapters(this.book);
          yield currentState.clone(
            type: BookStateType.successful,
            book: bookAndChapters.$0,
            chapterList: bookAndChapters.$1,
          );
        } else if (source is LocalSource) {
          yield currentState.clone();
        }
      } catch (error) {
        yield currentState.clone(
          type: BookStateType.failed,
          error: error,
        );
      }
    } else if (event is BookEventFavorite) {
      // todo
    }
  }
}

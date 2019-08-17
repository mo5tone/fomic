import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/book.dart';
import 'package:fomic/model/chapter.dart';

enum BookStateType {
  fetching,
  successful,
  failed,
}

class BookState extends base.State<BookStateType> {
  final Book book;
  final List<Chapter> chapterList;
  final Object error;
  final StackTrace stackTrace;

  BookState(
    BookStateType type, {
    this.book,
    this.chapterList = const [],
    this.error,
    this.stackTrace,
  })  : assert(book != null),
        super(type);

  @override
  clone({
    BookStateType type,
    Book book,
    List<Chapter> chapterList,
    Object error,
    StackTrace stackTrace,
  }) {
    return BookState(
      type ?? this.type,
      book: book ?? this.book,
      chapterList: chapterList ?? this.chapterList,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

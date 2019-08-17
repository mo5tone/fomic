import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/model/book.dart';
import 'package:fomic/model/chapter.dart';

class BookState extends base.State<BookState> {
  final Book book;
  bool isFetching = false;
  List<Chapter> chapterList = [];
  Object error;
  StackTrace stackTrace;

  BookState(this.book) : assert(book != null);

  @override
  BookState clone({
    Book book,
    bool isFetching,
    List<Chapter> chapterList,
    Object error,
    StackTrace stackTrace,
  }) {
    return BookState(book ?? this.book)
      ..isFetching = isFetching ?? false
      ..chapterList = chapterList ?? this.chapterList
      ..error = error
      ..stackTrace = stackTrace;
  }
}

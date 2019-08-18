import 'package:fomic/blocs/base/state.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/page.dart';

class ChapterState extends State<ChapterState> {
  final Chapter chapter;
  bool isFetching = false;
  bool isFullPage = true;
  int pageIndex = 0;
  List<Page> pageList = [];
  Object error;
  StackTrace stackTrace;

  ChapterState(this.chapter);

  @override
  ChapterState clone({
    Chapter chapter,
    bool isFetching,
    bool isFullPage,
    int pageIndex,
    List<Page> pageList,
    Object error,
    StackTrace stackTrace,
  }) {
    return ChapterState(chapter ?? this.chapter)
      ..isFetching = isFetching ?? false
      ..isFullPage = isFullPage ?? this.isFullPage
      ..pageIndex = pageIndex ?? this.pageIndex
      ..pageList = pageList ?? this.pageList
      ..error = error
      ..stackTrace = stackTrace;
  }
}

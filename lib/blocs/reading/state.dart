import 'package:fomic/blocs/base/state.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/page.dart';

enum ReadingStateType {
  fetching,
  successful,
  failed,
}

class ReadingState extends State<ReadingStateType> {
  final bool fullPage;
  final Chapter chapter;
  final int currentPageIndex;
  final List<Page> pageList;
  final Object error;
  final StackTrace stackTrace;

  ReadingState(
    ReadingStateType type, {
    this.fullPage = true,
    this.chapter,
    this.currentPageIndex = 0,
    this.pageList = const [],
    this.error,
    this.stackTrace,
  }) : super(type);

  @override
  clone({
    ReadingStateType type,
    bool fullPage,
    Chapter chapter,
    int currentPageIndex,
    List<Page> pageList,
    Object error,
    StackTrace stackTrace,
  }) {
    return ReadingState(
      type ?? this.type,
      fullPage: fullPage ?? this.fullPage,
      chapter: chapter ?? this.chapter,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      pageList: pageList ?? this.pageList,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

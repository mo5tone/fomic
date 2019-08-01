import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/page.dart';

enum ChapterStateType {
  fetching,
  fetchSuccess,
  fetchFailure,
}

class ChapterState implements Cloneable {
  final ChapterStateType type;
  final List<Page> pages;
  final Object error;
  final StackTrace stackTrace;

  ChapterState(
    this.type, {
    this.pages = const [],
    this.error,
    this.stackTrace,
  }) : assert(type != null);

  @override
  clone({
    ChapterStateType type,
    List<Page> pages,
    Object error,
    StackTrace stackTrace,
  }) {
    return ChapterState(
      type ?? this.type,
      pages: pages ?? this.pages,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

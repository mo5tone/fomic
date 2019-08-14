import 'package:fomic/blocs/base/state.dart';
import 'package:fomic/model/chapter.dart';

enum ReadingStateType {
  fetching,
  successful,
  failed,
}

class ReadingState extends State<ReadingStateType> {
  final bool fullPage;
  final Chapter chapter;

  ReadingState(
    ReadingStateType type, {
    this.fullPage = true,
    this.chapter,
  }) : super(type);

  @override
  int compareTo(other) {
    if (other is ReadingState) {
      if (other.fullPage != fullPage) {
        return 0x10;
      } else {
        return 0x01;
      }
    } else {
      return 0x00;
    }
  }

  @override
  clone({
    ReadingStateType type,
    bool fullPage,
    Chapter chapter,
  }) {
    return ReadingState(
      type ?? this.type,
      fullPage: fullPage ?? this.fullPage,
      chapter: chapter ?? this.chapter,
    );
  }
}

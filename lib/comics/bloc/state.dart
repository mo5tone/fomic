import 'package:fomic/model/comic.dart';

abstract class ComicsState {
  final List<Comic> comics;

  ComicsState(this.comics);
}

class ComicsStateFetching extends ComicsState {
  ComicsStateFetching(List<Comic> comics) : super(comics);
}

class ComicsStateFetchSuccess extends ComicsState {
  ComicsStateFetchSuccess(List<Comic> comics) : super(comics);
}

class ComicsStateFetchFailure extends ComicsState {
  final Object error;
  final StackTrace stackTrace;

  ComicsStateFetchFailure(
    this.error, {
    this.stackTrace,
    List<Comic> comics = const [],
  }) : super(comics);
}

import 'package:fomic/model/filter.dart';

abstract class ComicsEvent {}

class ComicsEventRefresh extends ComicsEvent {
  final String query;
  final List<Filter> filters;

  ComicsEventRefresh({
    this.query = '',
    this.filters = const [],
  });
}

class ComicsEventLoadMore extends ComicsEvent {
  final String query;
  final List<Filter> filters;

  ComicsEventLoadMore({
    this.query = '',
    this.filters = const [],
  });
}

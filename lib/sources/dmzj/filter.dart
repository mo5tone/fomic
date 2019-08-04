import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class GenreFilter extends SelectableFilter<Pair<String, String>> {
  GenreFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get value => options[state].second;
}

class StatusFilter extends SelectableFilter<Pair<String, String>> {
  StatusFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get value => options[state].second;
}

class TypeFilter extends SelectableFilter<Pair<String, String>> {
  TypeFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  get value => options[state].second;
}

class SortFilter extends SelectableFilter<Pair<String, String>> {
  SortFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get value => options[state].second;
}

class ReaderFilter extends SelectableFilter<Pair<String, String>> {
  ReaderFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get value => options[state].second;
}

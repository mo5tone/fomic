import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class GenreFilter extends SelectableFilter<Pair<String, String>> {
  GenreFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get key => option.first;

  @override
  String get value => option.second;

  @override
  List<String> get keys =>
      options.map((pair) => pair.first).toList(growable: false);
}

class StatusFilter extends SelectableFilter<Pair<String, String>> {
  StatusFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get key => option.first;

  @override
  String get value => option.second;

  @override
  List<String> get keys =>
      options.map((pair) => pair.first).toList(growable: false);
}

class TypeFilter extends SelectableFilter<Pair<String, String>> {
  TypeFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get key => option.first;

  @override
  get value => option.second;

  @override
  List<String> get keys =>
      options.map((pair) => pair.first).toList(growable: false);
}

class SortFilter extends SelectableFilter<Pair<String, String>> {
  SortFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get key => option.first;

  @override
  String get value => option.second;

  @override
  List<String> get keys =>
      options.map((pair) => pair.first).toList(growable: false);
}

class ReaderFilter extends SelectableFilter<Pair<String, String>> {
  ReaderFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get key => option.first;

  @override
  String get value => option.second;

  @override
  List<String> get keys =>
      options.map((pair) => pair.first).toList(growable: false);
}

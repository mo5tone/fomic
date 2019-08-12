import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends SelectableFilter<Pair<String, String>> {
  SortFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get alias => option[0];

  @override
  String get value => option[1];

  @override
  List<String> get aliases =>
      options.map((pair) => pair[0]).toList(growable: false);
}

class CategoryFilter
    extends SelectableFilter<Pair<String, Pair<String, String>>> {
  CategoryFilter(String name, List<Pair<String, Pair<String, String>>> options)
      : super(name, options);

  @override
  get alias => option[0];

  @override
  Pair<String, Pair<String, String>> get value => option;

  String get type => value[1][0];

  String get id => value[1][1];

  @override
  List<String> get aliases =>
      options.map((pair) => pair[0]).toList(growable: false);
}

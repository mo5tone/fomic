import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/helper/triplet.dart';
import 'package:fomic/model/filter.dart';

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

class CategoryFilter extends SelectableFilter<Triplet<String, String, String>> {
  CategoryFilter(String name, List<Triplet<String, String, String>> options)
      : super(name, options);

  @override
  get key => option.first;

  @override
  Triplet<String, String, String> get value => option;

  String get type => value.second;

  String get id => value.third;

  @override
  List<String> get keys =>
      options.map((triplet) => triplet.first).toList(growable: false);
}

import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/helper/triplet.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends SelectableFilter<Pair<String, String>> {
  SortFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get value => options[state].second;
}

class CategoryFilter extends SelectableFilter<Triplet<String, String, String>> {
  CategoryFilter(String name, List<Triplet<String, String, String>> options)
      : super(name, options);

  String get type => value.second;

  String get id => value.third;
}

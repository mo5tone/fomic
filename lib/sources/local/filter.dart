import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends SelectableFilter<Pair<String, String>> {
  SortFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get alias => option.first;

  @override
  String get value => option.second;

  @override
  List<String> get aliases =>
      options.map((pair) => pair.first).toList(growable: false);
}

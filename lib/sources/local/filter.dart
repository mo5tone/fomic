import 'package:fomic/common/helper/pair.dart';
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

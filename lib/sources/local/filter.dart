import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends SelectableFilter<String> {
  SortFilter(String name, List<Pair<String, String>> options)
      : super(name, options);

  @override
  String get alias => option.$0;

  @override
  String get value => option.$1;

  @override
  List<String> get aliases =>
      options.map((pair) => pair.$0).toList(growable: false);
}

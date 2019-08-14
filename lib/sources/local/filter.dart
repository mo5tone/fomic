import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends SelectableFilter<String> {
  SortFilter()
      : super('排序', [
          Pair('名称', '0'),
          Pair('大小', '1'),
          Pair('种类', '2'),
          Pair('时间', '3'),
        ]);

  @override
  String get alias => option.$0;

  @override
  String get value => option.$1;

  @override
  List<String> get aliases =>
      options.map((pair) => pair.$0).toList(growable: false);
}

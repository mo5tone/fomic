import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/filter.dart';

class LocalSource extends Source {
  @override
  SourceId get id => SourceId.local;

  @override
  String get name => '本地';

  @override
  List<Filter> get availableFilters => [
        SortFilter('排序', [
          Pair('名称', '0'),
          Pair('大小', '1'),
          Pair('种类', '2'),
          Pair('时间', '3'),
        ]),
      ];

  LocalSource._();

  static final LocalSource _instance = LocalSource._();

  factory LocalSource() => _instance;
}

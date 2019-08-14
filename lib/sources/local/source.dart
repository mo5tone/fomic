import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/local/filter.dart';

class LocalSource extends Source {
  @override
  SourceId get id => SourceId.local;

  @override
  String get name => '本地';

  @override
  List<Filter> get filters => [
        SortFilter(),
      ];

  LocalSource._();

  static final LocalSource _instance = LocalSource._();

  factory LocalSource() => _instance;
}

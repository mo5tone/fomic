import 'package:fomic/model/source_configuration.dart';
import 'package:fomic/repository/source/source.dart';

abstract class ConfigurableSource extends Source {
  List<SourceConfiguration> get configurations;
}

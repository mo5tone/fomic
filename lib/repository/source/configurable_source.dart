import 'package:flutter/widgets.dart';
import 'package:fomic/repository/source/source.dart';

class SourceConfiguration {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  SourceConfiguration({required this.itemCount, required this.itemBuilder}) : assert(itemCount > 0);
}

abstract class ConfigurableSource extends Source {
  SourceConfiguration get configuration;
}

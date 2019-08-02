import 'package:fomic/source/source_id.dart';

abstract class BaseSource {
  SourceID get id;

  void close();
}

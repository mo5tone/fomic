import 'package:fomic/model/source/local_source.dart';
import 'package:fomic/model/source/online/bn_man_hua.dart';
import 'package:fomic/model/source/online/dmzj.dart';
import 'package:get_it/get_it.dart';

class Sources {
  /// Local Source
  static LocalSource get local => GetIt.I.get();

  // Online Sources
  static DMZJ get dmzj => GetIt.I.get();
  static BNManHua get bnManHua => GetIt.I.get();
}

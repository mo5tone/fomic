import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/source/local_source.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:fomic/model/source/online/bn_man_hua.dart';
import 'package:fomic/model/source/online/dmzj.dart';

class Injector {
  static void register() {
    final getIt = GetIt.I;
    if (!getIt.isRegistered<Dio>()) {
      getIt.registerFactoryParam<Dio, BaseOptions, void>((options, abc) {
        final opts = options.merge(
          connectTimeout: 5000,
          receiveTimeout: 3000,
          sendTimeout: 3000,
        );
        return Dio(opts);
      });
    }
    SourceID.values.forEach((id) {
      switch (id) {
        case SourceID.local:
          if (!getIt.isRegistered<LocalSource>()) {
            getIt.registerLazySingleton(() => LocalSource());
          }
          break;
        case SourceID.dmzj:
          if (!getIt.isRegistered<DMZJ>()) {
            getIt.registerLazySingleton(() => DMZJ());
          }
          break;
        case SourceID.bnManHua:
          if (!getIt.isRegistered<BNManHua>()) {
            getIt.registerLazySingleton(() => BNManHua());
          }
          break;
      }
    });
  }
}

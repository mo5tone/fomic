import 'package:fomic/model/source/local_source.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:fomic/model/source/online/bn_man_hua.dart';
import 'package:fomic/model/source/online/dmzj.dart';

class Injector {
  static void register() {
    final getIt = GetIt.I;
    if (!getIt.isRegistered<Dio>()) {
      getIt.registerFactoryParam<Dio, BaseOptions, void>((options, _) => Dio(options));
    }
    // Local Source
    if (!getIt.isRegistered<LocalSource>()) {
      getIt.registerLazySingleton(() => LocalSource());
    }
    // Online sources
    if (!getIt.isRegistered<DMZJ>()) {
      getIt.registerLazySingleton(() => DMZJ());
    }
    if (!getIt.isRegistered<BNManHua>()) {
      getIt.registerLazySingleton(() => BNManHua());
    }
  }
}

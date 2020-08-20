import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static GetIt get _getter => GetIt.I;

  static void register() {
    if (!_getter.isRegistered<Dio>()) {
      _getter.registerFactoryParam<Dio, BaseOptions, void>((options, _) => Dio(options));
    }
  }
}

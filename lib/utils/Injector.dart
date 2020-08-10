import 'package:dio/dio.dart';
import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/scene/books/viewmodel/BooksViewModel.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static GetIt get _getter => GetIt.I;

  static void setup() {
    _dio();
    _viewmodels();
  }

  static void _dio() {
    if (!_getter.isRegistered<Dio>()) {
      _getter.registerFactoryParam<Dio, BaseOptions, void>((options, _) => Dio(options));
    }
  }

  static void _viewmodels() {
    if (!_getter.isRegistered<BooksViewModel>()) {
      _getter.registerFactoryParam<BooksViewModel, SourceId, void>((id, _) => BooksViewModel(id));
    }
  }
}

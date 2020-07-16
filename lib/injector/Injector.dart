import 'package:dio/dio.dart';
import 'package:fomic/model/constant/SourceID.dart';
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
      const agents = [
        'Mozilla/5.0 (X11; Linux x86_64)',
        'AppleWebKit/537.36 (KHTML, like Gecko)',
        'Chrome/56.0.2924.87',
        'Safari/537.36',
        'Fomic/1.0',
      ];
      final options = BaseOptions(
        headers: {
          'User-Agent': agents.join(' '),
        },
        validateStatus: (status) => 199 < status && status < 300,
      );
      _getter.registerLazySingleton<Dio>(() => Dio(options));
    }
  }

  static void _viewmodels() {
    if (!_getter.isRegistered<BooksViewModel>()) {
      _getter.registerFactoryParam<BooksViewModel, SourceID, void>((name, _) => BooksViewModel(name));
    }
  }
}

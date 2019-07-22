import 'package:dio/dio.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/page.dart';

import 'base_source.dart';

abstract class RemoteSource extends BaseSource {
  @override
  String get id => '$name[$baseUrl]';

  String get baseUrl;

  BaseOptions get baseOptions => BaseOptions(
        method: 'GET',
        connectTimeout: 1000 * 10,
        receiveTimeout: 1000 * 10,
        baseUrl: baseUrl,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 6.3; WOW64)',
        },
        validateStatus: (code) => code > 199 && code < 400,
      );

  List<InterceptorsWrapper> get interceptors => [];

  Dio get client {
    var dio = Dio(baseOptions);
    dio.interceptors.addAll([
      ...interceptors,
      LogInterceptor(responseBody: true),
    ]);
    return dio;
  }

  Future<List<Comic>> fetchComics(
      {int page = 0, String query = '', List<Filter> filters = const []});

  Future<Comic> fetchComic(Comic comic);

  Future<List<Chapter>> fetchChapters(Comic comic);

  Future<List<Page>> fetchPages(Chapter chapter);

  @override
  void close() {
    // do something to clean before closing.
  }
}

abstract class Fetcher<Output> {
  RequestOptions get requestOptions;

  Output onSuccess(Response response);

  Output onFailure(Object error, StackTrace stackTrace);

  final Dio client;
  final List<Type> errorTypes;

  Fetcher(
    this.client, {
    this.errorTypes = const [],
  });

  Future<Output> fetch() {
    return client
        .request(requestOptions.path, options: requestOptions)
        .then(onSuccess)
        .catchError(onFailure, test: (err) => (err is DioError) || toCatch(err));
  }

  bool toCatch(Object error) => true;
}

import 'package:dio/dio.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/source/base/base_source.dart';
import 'package:fomic/source/dmzj/dmzj.dart';
import 'package:fomic/source/manhuaren/manhuaren.dart';
import 'package:fomic/source/source_id.dart';

abstract class RemoteSource extends BaseSource {
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

  Dio get client => Dio(baseOptions)
    ..interceptors.addAll([
      InterceptorsWrapper(
        onResponse: (response) {
          dynamic data = response.data;
          bool shouldReject = false;
          switch (response.request.responseType) {
            case ResponseType.json:
              shouldReject = (data is! Map) && (data is! List);
              break;
            case ResponseType.stream:
              shouldReject = (data is! ResponseBody);
              break;
            case ResponseType.plain:
              shouldReject = (data is! String);
              break;
            case ResponseType.bytes:
              shouldReject = (data is! List<int>);
              break;
          }
          if (shouldReject) {
            return DioError(
              request: response.request,
              response: response,
              message:
                  'Expect ${response.request.responseType}, but get ${data.runtimeType}, data: $data',
            );
          }
          return response;
        },
      ),
      ...interceptors,
      LogInterceptor(),
    ]);

  RemoteSource();

  factory RemoteSource.of(SourceID id) {
    switch (id) {
      case SourceID.dmzj:
        return Dmzj();
      case SourceID.manhuaren:
        return Manhuaren();
      default:
        return null;
    }
  }

  Future<List<Comic>> fetchComics({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  });

  Future<Comic> fetchComic(Comic comic);

  Future<List<Chapter>> fetchChapters(Comic comic);

  Future<List<Page>> fetchPages(Chapter chapter);

  @override
  void close() {
    // todo: do something to clean before closing.
    client.clear();
  }
}

abstract class Fetcher<Output> {
  RequestOptions get requestOptions;

  Output onSuccess(Response response);

  Output onFailure(Object error, StackTrace stackTrace);

  final Dio client;

  Fetcher(this.client);

  bool toCatch(Object error) => false;

  Future<Output> fetch() {
    return client
        .request(requestOptions.path, options: requestOptions)
        .then(onSuccess)
        .catchError(
          onFailure,
          test: (err) => (err is DioError) || toCatch(err),
        );
  }
}

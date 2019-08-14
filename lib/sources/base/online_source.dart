import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/source.dart';

abstract class OnlineSource extends Source {
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
      StrictResponseType(),
      ...interceptors,
      LogInterceptor(),
    ]);

  Future<List<Manga>> fetchMangaList({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  });

  Future<Manga> fetchManga(Manga manga);

  Future<List<Chapter>> fetchChapterList(Manga manga);

  Future<Pair<Manga, List<Chapter>>> fetchMangaAndChapterList(Manga manga) {
    return fetchManga(manga).then((value) async {
      final chapterList = await fetchChapterList(value);
      return Pair(value, chapterList);
    });
  }

  Future<List<Page>> fetchPageList(Chapter chapter);
}

class StrictResponseType extends InterceptorsWrapper {
  @override
  FutureOr onResponse(Response response) {
    super.onResponse(response);
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
  }
}

abstract class Fetcher<Output> {
  RequestOptions get requestOptions;

  Output onSuccess(Response response);

  Output onFailure(Object error, StackTrace stackTrace);

  final OnlineSource source;
  final bool Function(Object) toCatch;

  Dio get client => source.client;

  Fetcher(this.source, {this.toCatch}) : assert(source != null);

  bool _test(Object error) {
    if (toCatch != null) {
      return (error is DioError) || toCatch(error);
    }
    return error is DioError;
  }

  Future<Output> fetch() {
    return client
        .request(requestOptions.path, options: requestOptions)
        .then(onSuccess)
        .catchError(onFailure, test: _test);
  }
}

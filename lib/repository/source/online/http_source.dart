import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/service/network/cache/dio_file_service.dart';
import 'package:fomic/repository/service/network/interceptor/loading_indicator.dart';
import 'package:fomic/repository/service/network/networker.dart';
import 'package:fomic/repository/service/network/request.dart';
import 'package:fomic/repository/service/source_box.dart';
import 'package:fomic/repository/source/catalogue_source.dart';
import 'package:fomic/repository/source/online/zh/bai_man_gu.dart';
import 'package:fomic/repository/source/online/zh/kuai_kan_man_hua.dart';
import 'package:fomic/repository/source/online/zh/wu_qi_manhua.dart';
import 'package:fomic/repository/source/online/zh/zero_byw.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class HTTPSource with Networker implements CatalogueSource {
  static final all = Provider.autoDispose<List<HTTPSource>>((ref) {
    return [
      ref.read(KuaiKanManHua.provider),
      ref.read(ZeroBYW.provider),
      ref.read(WuQiManHua.provider),
      ref.read(BaiManGu.provider),
    ];
  });

  static final provider = StateProvider<HTTPSource>((ref) {
    final sources = ref.read(all);
    final id = ref.watch(SourceBox.provider).whenOrNull(data: (box) => box)?.id;
    return sources.firstWhere((source) => id == source.id, orElse: () => sources.first);
  });

  @protected
  @override
  late Dio dio;

  int get version => 1;

  String get commit;

  @override
  int get id {
    final input = '${name.toLowerCase()}/$lang/$version';
    final digest = md5.convert(utf8.encode(input));
    final bytes = digest.bytes;
    return List.generate(8, (i) => i).map((i) => (bytes[i % bytes.length] & 0xff) << (8 * (7 - i))).reduce((v, e) => v | e) & ((1 << 63) - 1);
  }

  String get baseUrl;

  Map<String, String> get headers => {};

  Iterable<Interceptor> get interceptors => const Iterable.empty();

  BaseCacheManager get cacheManager => CacheManager(Config('HTTPSource_$id', fileService: DioFileService(dio)));

  List<SourceFilter> get filters => [];

  String get iconName => 'assets/images/ic_launcher_$runtimeType.png';

  HTTPSource(Ref ref) {
    const userAgents = [
      'Mozilla/5.0',
      '(Windows NT 10.0; Win64; x64)',
      'AppleWebKit/537.36',
      '(KHTML, like Gecko)',
      'Chrome/88.0.4324.150',
      'Safari/537.36',
      'Edg/88.0.705.63',
    ];
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'User-Agent': userAgents.join(' '),
        ...headers,
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
      sendTimeout: 3000,
    );
    dio = Dio(baseOptions)
      ..interceptors.addAll(interceptors)
      ..interceptors.add(ref.read(LoadingIndicator.provider));
  }

  @override
  String toString() => '$name (${lang.toUpperCase()})';

  @protected
  Request popularMangaRequest({required int page});
  @protected
  FutureOr<SourceMangasPage> popularMangaParser(Response<dynamic> response);

  @override
  FutureOr<SourceMangasPage> fetchPopularManga({required int page}) {
    return fetch<SourceMangasPage>(popularMangaRequest(page: page), parser: popularMangaParser);
  }

  @protected
  Request searchMangaRequest({required int page, required String query, required List<SourceFilter> filters});
  @protected
  FutureOr<SourceMangasPage> searchMangaParser(Response<dynamic> response);

  @override
  FutureOr<SourceMangasPage> searchManga({required int page, required String query, required List<SourceFilter> filters}) {
    return fetch<SourceMangasPage>(searchMangaRequest(page: page, query: query, filters: filters), parser: searchMangaParser);
  }

  @protected
  Request latestUpdatesRequest({required int page});
  @protected
  FutureOr<SourceMangasPage> latestUpdatesParser(Response<dynamic> response);

  @override
  FutureOr<SourceMangasPage> fetchLatestUpdates({required int page}) {
    return fetch<SourceMangasPage>(latestUpdatesRequest(page: page), parser: latestUpdatesParser);
  }

  @protected
  Request mangaDetailsRequest({required SourceManga manga}) => Request(manga.key).copyWithManga(manga);
  @protected
  FutureOr<SourceManga> mangaDetailsParser(Response<dynamic> response);

  @override
  FutureOr<SourceManga> fetchMangaDetails({required SourceManga manga}) {
    return fetch<SourceManga>(mangaDetailsRequest(manga: manga), parser: mangaDetailsParser).then((value) => value.copyWith(key: manga.key));
  }

  @protected
  Request chapterListRequest({required SourceManga manga}) => Request(manga.key).copyWithManga(manga);
  @protected
  FutureOr<List<SourceChapter>> chapterListParser(Response<dynamic> response);

  @override
  FutureOr<List<SourceChapter>> fetchChapterList({required SourceManga manga}) {
    return fetch<List<SourceChapter>>(chapterListRequest(manga: manga), parser: chapterListParser);
  }

  @protected
  Request pageListRequest({required SourceChapter chapter}) => Request(chapter.key).copyWithChapter(chapter);
  @protected
  FutureOr<List<SourcePage>> pageListParser(Response<dynamic> response);

  @override
  FutureOr<List<SourcePage>> fetchPageList({required SourceChapter chapter}) {
    return fetch<List<SourcePage>>(pageListRequest(chapter: chapter), parser: pageListParser);
  }

  @protected
  Request imageUrlRequest({required SourcePageUrl page}) => Request(page.url);
  @protected
  FutureOr<SourcePageImageUrl> imageUrlParser(Response<dynamic> response);

  FutureOr<SourcePageImageUrl> fetchPageImageUrl({required SourcePageUrl page}) {
    return fetch<SourcePageImageUrl>(imageUrlRequest(page: page), parser: imageUrlParser);
  }
}

extension BaseUrlExtension on String {
  String addBaseUrl(String baseURL) {
    if (RegExp(r'^https?:\/{2}[\d\w][\d\w\.]+\/').firstMatch(this) != null) {
      return this;
    }
    return baseURL.replaceFirstMapped(RegExp(r'\/+$'), (match) => '') + replaceFirstMapped(RegExp(r'^[^\/]*\/'), (match) => '/');
  }

  String get removedBaseUrl =>
      replaceFirstMapped(RegExp(r'^https?:\/{2}[\d\w][\d\w\.]+\/'), (match) => '/').replaceFirstMapped(RegExp(r'^[^\/]*\/'), (match) => '/');
}

extension RequestSourceModelGetters on Request {
  SourceManga? get manga => options?.extra?['manga'];
  SourceChapter? get chapter => options?.extra?['chapter'];

  Request copyWithManga(SourceManga? value) {
    final opt = options ?? Options();
    opt.extra ??= <String, dynamic>{};
    opt.extra?['manga'] = value;
    return copyWith(options: opt);
  }

  Request copyWithChapter(SourceChapter? value) {
    final opt = options ?? Options();
    opt.extra ??= <String, dynamic>{};
    opt.extra?['chapter'] = value;
    return copyWith(options: opt);
  }
}

extension ResponseSourceModelGetters on Response {
  SourceManga? get manga => requestOptions.extra['manga'];
  SourceChapter? get chapter => requestOptions.extra['chapter'];
}

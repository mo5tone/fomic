import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/service/network/networker.dart';
import 'package:fomic/repository/source/catalogue_source.dart';
import 'package:fomic/repository/source/online/zh/zero_byw.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class HTTPSource extends CatalogueSource {
  static final provider = Provider<HTTPSource>((ref) => ref.read(ZeroBYW.provider));

  @protected
  late Networker networker;

  String get version;
  String get baseUrl;
  Map<String, String> get headers;
  List<Filter> get filters;

  @override
  int get id => '${name.toLowerCase()}/$lang/$version'.hashCode;

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
    final baseOptions = BaseOptions(baseUrl: baseUrl, headers: {
      'User-Agent': userAgents.join(' '),
      ...headers,
    });
    networker = ref.read(Networker.family(baseOptions));
  }

  @protected
  RequestOptions popularMangaRequest({required int page});
  @protected
  MangasPage popularMangaParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchPopularManga({required int page}) {
    return networker.fetch<MangasPage>(popularMangaRequest(page: page), parser: popularMangaParser);
  }

  @protected
  RequestOptions searchMangaRequest({required int page, required String query, required List<Filter> filters});
  @protected
  MangasPage searchMangaParser(Response<dynamic> response);

  @override
  Future<MangasPage> searchManga({required int page, required String query, required List<Filter> filters}) {
    return networker.fetch<MangasPage>(searchMangaRequest(page: page, query: query, filters: filters), parser: searchMangaParser);
  }

  @protected
  RequestOptions latestUpdatesRequest({required int page});
  @protected
  MangasPage latestUpdatesParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchLatestUpdates({required int page}) {
    return networker.fetch<MangasPage>(latestUpdatesRequest(page: page), parser: latestUpdatesParser);
  }

  @protected
  RequestOptions mangaDetailsRequest({required MangaInfo manga}) => RequestOptions(baseUrl: baseUrl, path: manga.key);
  @protected
  MangaInfo mangaDetailsParser(Response<dynamic> response);

  @override
  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga}) {
    return networker.fetch<MangaInfo>(mangaDetailsRequest(manga: manga), parser: mangaDetailsParser).then((value) => value.copyWith(key: manga.key));
  }

  @protected
  RequestOptions chapterListRequest({required MangaInfo manga}) => RequestOptions(baseUrl: baseUrl, path: manga.key);
  @protected
  List<ChapterInfo> chapterListParser(Response<dynamic> response);

  @override
  Future<List<ChapterInfo>> fetchChapterList({required MangaInfo manga}) {
    return networker.fetch<List<ChapterInfo>>(chapterListRequest(manga: manga), parser: chapterListParser);
  }

  @protected
  RequestOptions pageListRequest({required ChapterInfo chapter}) => RequestOptions(baseUrl: baseUrl, path: chapter.key);
  @protected
  List<Page> pageListParser(Response<dynamic> response);

  @override
  Future<List<Page>> fetchPageList({required ChapterInfo chapter}) {
    return networker.fetch<List<Page>>(pageListRequest(chapter: chapter), parser: pageListParser);
  }

  @protected
  RequestOptions imageUrlRequest({required PageUrl page}) => RequestOptions(baseUrl: baseUrl, path: page.url);
  @protected
  PageImageUrl imageUrlParser(Response<dynamic> response);

  Future<PageImageUrl> fetchPageImageUrl({required PageUrl page}) {
    return networker.fetch<PageImageUrl>(imageUrlRequest(page: page), parser: imageUrlParser);
  }
}

extension BaseURLExtension on String {
  String addBaseURL(String baseURL) {
    if (RegExp(r'^https?:\/{2}[\d\w][\d\w\.]+\/').firstMatch(this) != null) {
      return this;
    }
    return baseURL.replaceFirstMapped(RegExp(r'\/+$'), (match) => '') + replaceFirstMapped(RegExp(r'^[^\/]*\/'), (match) => '/');
  }

  String get removedBaseURL =>
      replaceFirstMapped(RegExp(r'^https?:\/{2}[\d\w][\d\w\.]+\/'), (match) => '/').replaceFirstMapped(RegExp(r'^[^\/]*\/'), (match) => '/');
}

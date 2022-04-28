import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_manga_list.dart';
import 'package:fomic/model/source_page.dart';
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
  List<SourceFilter> get filters;

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
  SourceMangaList popularMangaParser(Response<dynamic> response);

  @override
  Future<SourceMangaList> fetchPopularManga({required int page}) {
    return networker.fetch<SourceMangaList>(popularMangaRequest(page: page), parser: popularMangaParser);
  }

  @protected
  RequestOptions searchMangaRequest({required int page, required String query, required List<SourceFilter> filters});
  @protected
  SourceMangaList searchMangaParser(Response<dynamic> response);

  @override
  Future<SourceMangaList> searchManga({required int page, required String query, required List<SourceFilter> filters}) {
    return networker.fetch<SourceMangaList>(searchMangaRequest(page: page, query: query, filters: filters), parser: searchMangaParser);
  }

  @protected
  RequestOptions latestUpdatesRequest({required int page});
  @protected
  SourceMangaList latestUpdatesParser(Response<dynamic> response);

  @override
  Future<SourceMangaList> fetchLatestUpdates({required int page}) {
    return networker.fetch<SourceMangaList>(latestUpdatesRequest(page: page), parser: latestUpdatesParser);
  }

  @protected
  RequestOptions mangaDetailsRequest({required SourceManga manga}) => RequestOptions(baseUrl: baseUrl, path: manga.key);
  @protected
  SourceManga mangaDetailsParser(Response<dynamic> response);

  @override
  Future<SourceManga> fetchMangaDetails({required SourceManga manga}) {
    return networker.fetch<SourceManga>(mangaDetailsRequest(manga: manga), parser: mangaDetailsParser).then((value) => value.copyWith(key: manga.key));
  }

  @protected
  RequestOptions chapterListRequest({required SourceManga manga}) => RequestOptions(baseUrl: baseUrl, path: manga.key);
  @protected
  List<SourceChapter> chapterListParser(Response<dynamic> response);

  @override
  Future<List<SourceChapter>> fetchChapterList({required SourceManga manga}) {
    return networker.fetch<List<SourceChapter>>(chapterListRequest(manga: manga), parser: chapterListParser);
  }

  @protected
  RequestOptions pageListRequest({required SourceChapter chapter}) => RequestOptions(baseUrl: baseUrl, path: chapter.key);
  @protected
  List<SourcePage> pageListParser(Response<dynamic> response);

  @override
  Future<List<SourcePage>> fetchPageList({required SourceChapter chapter}) {
    return networker.fetch<List<SourcePage>>(pageListRequest(chapter: chapter), parser: pageListParser);
  }

  @protected
  RequestOptions imageUrlRequest({required SourcePageUrl page}) => RequestOptions(baseUrl: baseUrl, path: page.url);
  @protected
  SourcePageImageUrl imageUrlParser(Response<dynamic> response);

  Future<SourcePageImageUrl> fetchPageImageUrl({required SourcePageUrl page}) {
    return networker.fetch<SourcePageImageUrl>(imageUrlRequest(page: page), parser: imageUrlParser);
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

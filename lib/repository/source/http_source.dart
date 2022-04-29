import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/service/network/networker.dart';
import 'package:fomic/repository/service/network/request.dart';
import 'package:fomic/repository/service/source_box.dart';
import 'package:fomic/repository/source/catalogue_source.dart';
import 'package:fomic/repository/source/online/zh/kuai_kan_man_hua.dart';
import 'package:fomic/repository/source/online/zh/zero_byw.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class HTTPSource extends CatalogueSource {
  static final all = Provider.autoDispose<List<HTTPSource>>((ref) {
    return [
      ref.read(KuaiKanManHua.provider),
      ref.read(ZeroBYW.provider),
    ];
  });

  static final provider = StateProvider<HTTPSource>((ref) {
    final sources = ref.read(all);
    return sources.firstWhere(
      (source) => ref.watch(SourceBox.provider).whenOrNull(data: (box) => box)?.id == source.id,
      orElse: () => sources.first,
    );
  });

  @protected
  late Networker networker;

  String get version;

  String get baseUrl;

  @override
  int get id => '${name.toLowerCase()}/$lang/$version'.hashCode;

  Map<String, String> get headers => {};

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
    final baseOptions = BaseOptions(baseUrl: baseUrl, headers: {
      'User-Agent': userAgents.join(' '),
      ...headers,
    });
    networker = ref.read(Networker.family(baseOptions));
  }

  @override
  String toString() => '$name (${lang.toUpperCase()})';

  @protected
  Request popularMangaRequest({required int page});
  @protected
  SourceMangasPage popularMangaParser(Response<dynamic> response);

  @override
  Future<SourceMangasPage> fetchPopularManga({required int page}) {
    return networker.fetch<SourceMangasPage>(popularMangaRequest(page: page), parser: popularMangaParser);
  }

  @protected
  Request searchMangaRequest({required int page, required String query, required List<SourceFilter> filters});
  @protected
  SourceMangasPage searchMangaParser(Response<dynamic> response);

  @override
  Future<SourceMangasPage> searchManga({required int page, required String query, required List<SourceFilter> filters}) {
    return networker.fetch<SourceMangasPage>(searchMangaRequest(page: page, query: query, filters: filters), parser: searchMangaParser);
  }

  @protected
  Request latestUpdatesRequest({required int page});
  @protected
  SourceMangasPage latestUpdatesParser(Response<dynamic> response);

  @override
  Future<SourceMangasPage> fetchLatestUpdates({required int page}) {
    return networker.fetch<SourceMangasPage>(latestUpdatesRequest(page: page), parser: latestUpdatesParser);
  }

  @protected
  Request mangaDetailsRequest({required SourceManga manga}) => Request(manga.key);
  @protected
  SourceManga mangaDetailsParser(Response<dynamic> response);

  @override
  Future<SourceManga> fetchMangaDetails({required SourceManga manga}) {
    return networker.fetch<SourceManga>(mangaDetailsRequest(manga: manga), parser: mangaDetailsParser).then((value) => value.copyWith(key: manga.key));
  }

  @protected
  Request chapterListRequest({required SourceManga manga}) => Request(manga.key);
  @protected
  List<SourceChapter> chapterListParser(Response<dynamic> response);

  @override
  Future<List<SourceChapter>> fetchChapterList({required SourceManga manga}) {
    return networker.fetch<List<SourceChapter>>(chapterListRequest(manga: manga), parser: chapterListParser);
  }

  @protected
  Request pageListRequest({required SourceChapter chapter}) => Request(chapter.key);
  @protected
  List<SourcePage> pageListParser(Response<dynamic> response);

  @override
  Future<List<SourcePage>> fetchPageList({required SourceChapter chapter}) {
    return networker.fetch<List<SourcePage>>(pageListRequest(chapter: chapter), parser: pageListParser);
  }

  @protected
  Request imageUrlRequest({required SourcePageUrl page}) => Request(page.url);
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

extension Extra on Request {
  SourceManga? get manga => options?.extra?['manga'];

  // set manga(SourceManga? value) {
  //   options ??= Options();
  // }
}

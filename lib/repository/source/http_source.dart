import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/service/networker.dart';
import 'package:fomic/repository/source/catalogue_source.dart';

abstract class HttpSource extends CatalogueSource {
  @protected
  late Networker networker;
  final int version = 1;

  String get baseUrl;
  Map<String, String> get headers;
  List<Filter> get filters;

  HttpSource(ProviderRefBase ref) {
    const userAgents = [
      'Mozilla/5.0',
      '(Windows NT 10.0; Win64; x64)',
      'AppleWebKit/537.36',
      '(KHTML, like Gecko)',
      'Chrome/88.0.4324.150',
      'Safari/537.36',
      'Edg/88.0.705.63',
    ];
    networker = ref.read(Networker.family(BaseOptions(baseUrl: baseUrl, headers: {
      'User-Agent': userAgents.join(' '),
      ...headers,
    })));
  }

  FutureOr<MangasPage> fetchMangasPageFailed(dynamic error, StackTrace stackTrace) => MangasPage.empty();

  RequestOptions popularMangaRequest({required int page});
  MangasPage popularMangaParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchPopularManga({required int page}) {
    return networker.fetch<MangasPage>(popularMangaRequest(page: page), popularMangaParser).catchError(fetchMangasPageFailed);
  }

  RequestOptions searchMangaRequest({required int page, required String query, required List<Filter> filters});
  MangasPage searchMangaParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchSearchManga({required int page, required String query, required List<Filter> filters}) {
    return networker.fetch<MangasPage>(searchMangaRequest(page: page, query: query, filters: filters), searchMangaParser).catchError(fetchMangasPageFailed);
  }

  RequestOptions latestUpdatesRequest({required int page});
  MangasPage latestUpdatesParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchLatestUpdates({required int page}) {
    return networker.fetch<MangasPage>(latestUpdatesRequest(page: page), latestUpdatesParser).catchError(fetchMangasPageFailed);
  }

  RequestOptions mangaDetailsRequest({required MangaInfo manga}) => RequestOptions(path: manga.key);
  MangaInfo mangaDetailsParser(Response<dynamic> response);

  @override
  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga}) {
    return networker.fetch<MangaInfo>(mangaDetailsRequest(manga: manga), mangaDetailsParser).then((value) => value.copyWith(key: manga.key));
  }

  RequestOptions chapterListRequest({required MangaInfo manga}) => RequestOptions(path: manga.key);
  List<ChapterInfo> chapterListParser(Response<dynamic> response);

  @override
  Future<List<ChapterInfo>> fetchChapterList({required MangaInfo manga}) {
    return networker.fetch<List<ChapterInfo>>(chapterListRequest(manga: manga), chapterListParser);
  }

  RequestOptions pageListRequest({required ChapterInfo chapter}) => RequestOptions(path: chapter.key);
  List<Page> pageListParser(Response<dynamic> response);

  @override
  Future<List<Page>> fetchPageList({required ChapterInfo chapter}) {
    return networker.fetch<List<Page>>(pageListRequest(chapter: chapter), pageListParser);
  }

  RequestOptions imageUrlRequest({required PageUrl page}) => RequestOptions(path: page.url);
  PageImageUrl imageUrlParser(Response<dynamic> response);

  Future<PageImageUrl> getPageImageUrl({required PageUrl page}) {
    return networker.fetch<PageImageUrl>(imageUrlRequest(page: page), imageUrlParser);
  }
}

extension on Uri {
  String get withoutHost {
    var output = path;
    if (query.isNotEmpty) {
      output += '?' + query;
    }
    if (fragment.isNotEmpty) {
      output += '#' + fragment;
    }
    return output;
  }
}

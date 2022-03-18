import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/repository/service/request.dart';
import 'package:fomic/repository/source/online/kuai_kan_man_hua.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/service/networker.dart';
import 'package:fomic/repository/source/catalogue_source.dart';

abstract class HttpSource extends CatalogueSource {
  static final provider = Provider<HttpSource>((ref) => ref.read(KuaiKanManHua.provider));

  @protected
  late Networker networker;

  int get version;
  String get baseUrl;
  Map<String, String> get headers;
  List<Filter> get filters;

  @override
  int get id => '${name.toLowerCase()}/$lang/$version'.hashCode;

  HttpSource(Ref ref) {
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
  Request popularMangaRequest({required int page});
  @protected
  MangasPage popularMangaParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchPopularManga({required int page}) {
    return networker.fetch<MangasPage>(popularMangaRequest(page: page), parser: popularMangaParser);
  }

  @protected
  Request searchMangaRequest({required int page, required String query, required List<Filter> filters});
  @protected
  MangasPage searchMangaParser(Response<dynamic> response);

  @override
  Future<MangasPage> searchManga({required int page, required String query, required List<Filter> filters}) {
    return networker.fetch<MangasPage>(searchMangaRequest(page: page, query: query, filters: filters), parser: searchMangaParser);
  }

  @protected
  Request latestUpdatesRequest({required int page});
  @protected
  MangasPage latestUpdatesParser(Response<dynamic> response);

  @override
  Future<MangasPage> fetchLatestUpdates({required int page}) {
    return networker.fetch<MangasPage>(latestUpdatesRequest(page: page), parser: latestUpdatesParser);
  }

  @protected
  Request mangaDetailsRequest({required MangaInfo manga}) => Request(path: manga.key);
  @protected
  MangaInfo mangaDetailsParser(Response<dynamic> response);

  @override
  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga}) {
    return networker.fetch<MangaInfo>(mangaDetailsRequest(manga: manga), parser: mangaDetailsParser).then((value) => value.copyWith(key: manga.key));
  }

  @protected
  Request chapterListRequest({required MangaInfo manga}) => Request(path: manga.key);
  @protected
  List<ChapterInfo> chapterListParser(Response<dynamic> response);

  @override
  Future<List<ChapterInfo>> fetchChapterList({required MangaInfo manga}) {
    return networker.fetch<List<ChapterInfo>>(chapterListRequest(manga: manga), parser: chapterListParser);
  }

  @protected
  Request pageListRequest({required ChapterInfo chapter}) => Request(path: chapter.key);
  @protected
  List<Page> pageListParser(Response<dynamic> response);

  @override
  Future<List<Page>> fetchPageList({required ChapterInfo chapter}) {
    return networker.fetch<List<Page>>(pageListRequest(chapter: chapter), parser: pageListParser);
  }

  @protected
  Request imageUrlRequest({required PageUrl page}) => Request(path: page.url);
  @protected
  PageImageUrl imageUrlParser(Response<dynamic> response);

  Future<PageImageUrl> fetchPageImageUrl({required PageUrl page}) {
    return networker.fetch<PageImageUrl>(imageUrlRequest(page: page), parser: imageUrlParser);
  }
}

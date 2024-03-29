import 'dart:async';

import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/source/catalogue_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocalSource extends CatalogueSource {
  static final provider = Provider.autoDispose((ref) => LocalSource());
  static const supportedArchiveTypes = ['zip', 'rar', 'cbr', 'cbz', 'epub'];

  @override
  int get id => 0;

  @override
  String get name => '本地资源';

  @override
  String get lang => 'zh';

  @override
  // TODO: implement supportsLatest
  bool get supportsLatest => throw UnimplementedError();

  @override
  FutureOr<SourceMangasPage> fetchLatestUpdates({required int page}) {
    // TODO: implement fetchLatestUpdates
    throw UnimplementedError();
  }

  @override
  FutureOr<SourceMangasPage> fetchPopularManga({required int page}) {
    // TODO: implement fetchPopularManga
    throw UnimplementedError();
  }

  @override
  FutureOr<SourceMangasPage> searchManga({required int page, required String query, required List<SourceFilter> filters}) {
    // TODO: implement fetchSearchManga
    throw UnimplementedError();
  }

  @override
  FutureOr<List<SourceChapter>> fetchChapterList({required SourceManga manga}) {
    // TODO: implement getChapterList
    throw UnimplementedError();
  }

  @override
  FutureOr<SourceManga> fetchMangaDetails({required SourceManga manga}) {
    // TODO: implement getMangaDetails
    throw UnimplementedError();
  }

  @override
  FutureOr<List<SourcePage>> fetchPageList({required SourceChapter chapter}) {
    // TODO: implement getPageList
    throw UnimplementedError();
  }
}

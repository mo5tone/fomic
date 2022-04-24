import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/page.dart';
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
  Future<MangasPage> fetchLatestUpdates({required int page}) {
    // TODO: implement fetchLatestUpdates
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> fetchPopularManga({required int page}) {
    // TODO: implement fetchPopularManga
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> searchManga({required int page, required String query, required List<Filter> filters}) {
    // TODO: implement fetchSearchManga
    throw UnimplementedError();
  }

  @override
  Future<List<ChapterInfo>> fetchChapterList({required MangaInfo manga}) {
    // TODO: implement getChapterList
    throw UnimplementedError();
  }

  @override
  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga}) {
    // TODO: implement getMangaDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Page>> fetchPageList({required ChapterInfo chapter}) {
    // TODO: implement getPageList
    throw UnimplementedError();
  }
}

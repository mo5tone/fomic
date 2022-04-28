import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga_list.dart';
import 'package:fomic/repository/source/source.dart';

abstract class CatalogueSource extends Source {
  /// Whether the source has support for latest updates.
  bool get supportsLatest;

  Future<SourceMangaList> fetchPopularManga({required int page});
  Future<SourceMangaList> searchManga({required int page, required String query, required List<SourceFilter> filters});
  Future<SourceMangaList> fetchLatestUpdates({required int page});
}

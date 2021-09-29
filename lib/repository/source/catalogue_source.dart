import 'package:fomic/model/filter.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/repository/source/source.dart';

abstract class CatalogueSource extends Source {
  bool get supportsLatest;

  Future<MangasPage> fetchPopularManga({required int page});
  Future<MangasPage> fetchSearchManga({required int page, required String query, required List<Filter> filters});
  Future<MangasPage> fetchLatestUpdates({required int page});
}

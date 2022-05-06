import 'dart:async';

import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/repository/source/source.dart';

abstract class CatalogueSource extends Source {
  /// Whether the source has support for latest updates.
  bool get supportsLatest;

  FutureOr<SourceMangasPage> fetchPopularManga({required int page});
  FutureOr<SourceMangasPage> searchManga({required int page, required String query, required List<SourceFilter> filters});
  FutureOr<SourceMangasPage> fetchLatestUpdates({required int page});
}

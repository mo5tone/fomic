import 'package:fomic/model/source_manga.dart';

class SourceMangaList {
  final List<SourceManga> mangas;
  final bool hasNextPage;

  SourceMangaList(this.mangas, this.hasNextPage);
}

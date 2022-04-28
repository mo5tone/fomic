import 'package:fomic/model/source_manga.dart';

class SourceMangasPage {
  final List<SourceManga> mangas;
  final bool hasNextPage;

  SourceMangasPage(this.mangas, this.hasNextPage);
}

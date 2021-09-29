import 'package:fomic/model/manga_info.dart';

class MangasPage {
  final int number;
  final List<MangaInfo> mangas;
  final bool hasNextPage;

  MangasPage(this.number, this.mangas, this.hasNextPage);

  factory MangasPage.empty() => MangasPage(0, [], false);
}

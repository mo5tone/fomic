import 'package:fomic/common/helper/cloneable.dart';

import 'manga.dart';
import 'page.dart';

class Chapter implements Cloneable {
  final Manga manga;
  final String url;
  final String name;
  final DateTime updateAt;
  final num chapterNumber;

  Chapter({
    this.manga,
    this.url,
    this.name,
    this.updateAt,
    this.chapterNumber,
  });

  @override
  clone({
    Manga manga,
    String url,
    String name,
    DateTime updateAt,
    num chapterNumber,
    List<Page> pages,
  }) {
    return Chapter(
      manga: manga ?? this.manga,
      url: url ?? this.url,
      name: name ?? this.name,
      updateAt: updateAt ?? this.updateAt,
      chapterNumber: chapterNumber ?? this.chapterNumber,
    );
  }
}

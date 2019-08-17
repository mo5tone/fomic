import 'package:fomic/common/helper/cloneable.dart';

import 'book.dart';
import 'page.dart';

class Chapter implements Cloneable {
  final Book book;
  final String url;
  final String name;
  final DateTime updateAt;
  final num chapterNumber;

  Chapter({
    this.book,
    this.url,
    this.name,
    this.updateAt,
    this.chapterNumber,
  });

  @override
  clone({
    Book book,
    String url,
    String name,
    DateTime updateAt,
    num chapterNumber,
    List<Page> pages,
  }) {
    return Chapter(
      book: book ?? this.book,
      url: url ?? this.url,
      name: name ?? this.name,
      updateAt: updateAt ?? this.updateAt,
      chapterNumber: chapterNumber ?? this.chapterNumber,
    );
  }
}

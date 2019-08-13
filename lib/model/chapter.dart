import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/source.dart';

class Chapter implements Cloneable {
  final SourceId sourceId;
  final String url;
  final String name;
  final DateTime updateAt;
  final num chapterNumber;
  final List<Page> pages;

  Chapter({
    this.sourceId,
    this.url,
    this.name,
    this.updateAt,
    this.chapterNumber,
    this.pages = const [],
  });

  @override
  clone({
    SourceId sourceId,
    String url,
    String name,
    DateTime updateAt,
    num chapterNumber,
    List<Page> pages,
  }) {
    return Chapter(
      sourceId: sourceId ?? this.sourceId,
      url: url ?? this.url,
      name: name ?? this.name,
      updateAt: updateAt ?? this.updateAt,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      pages: pages ?? this.pages,
    );
  }
}

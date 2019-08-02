import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/source/source_id.dart';

class Chapter implements Cloneable {
  SourceID id;
  String url;
  String name;
  DateTime updateAt;
  num chapterNumber;
  List<Page> pages = [];

  @override
  String toString() {
    return '''
    {
      id: ${id.index},
      url: $url,
      name: $name,
      updateAt: $updateAt,
      chapterNumber: $chapterNumber,
      pages: $pages,
    }
    ''';
  }

  @override
  clone({
    String url,
    String name,
    DateTime updateAt,
    num chapterNumber,
    List<Page> pages,
  }) {
    return Chapter()
      ..id = this.id
      ..url = url ?? this.url
      ..name = name ?? this.name
      ..updateAt = updateAt ?? this.updateAt
      ..chapterNumber = chapterNumber ?? this.chapterNumber
      ..pages = pages ?? this.pages;
  }
}

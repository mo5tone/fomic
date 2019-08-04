import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/source.dart';

class Chapter implements Cloneable {
  Source source;
  String url;
  String name;
  DateTime updateAt;
  num chapterNumber;
  List<Page> pages = [];

  @override
  String toString() {
    return '''
    {
      source: ${source.runtimeType},
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
      ..source = this.source
      ..url = url ?? this.url
      ..name = name ?? this.name
      ..updateAt = updateAt ?? this.updateAt
      ..chapterNumber = chapterNumber ?? this.chapterNumber
      ..pages = pages ?? this.pages;
  }
}

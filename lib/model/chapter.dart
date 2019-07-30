import 'package:fomic/common/helper/cloneable.dart';

class Chapter implements Cloneable {
  String name;
  DateTime updateAt;
  String url;
  num chapterNumber;

  @override
  String toString() {
    return '''
    Chapter {
      name: $name,
      updateAt: $updateAt,
      chapterNumber: $chapterNumber,
      url: $url,
    }
    ''';
  }

  @override
  clone({
    String name,
    DateTime updateAt,
    String url,
    num chapterNumber,
  }) {
    return Chapter()
      ..name = name ?? this.name
      ..updateAt = updateAt ?? this.updateAt
      ..url = url ?? this.url
      ..chapterNumber = chapterNumber ?? this.chapterNumber;
  }
}

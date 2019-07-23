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
  clone() {
    return Chapter()
      ..name = name
      ..updateAt = updateAt
      ..url = url
      ..chapterNumber = chapterNumber;
  }
}

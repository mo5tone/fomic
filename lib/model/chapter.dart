import 'cloneable.dart';

class Chapter implements Cloneable {
  String name;
  DateTime dateUpload;
  String url;
  num chapterNumber;

  @override
  String toString() {
    return '''
    Chapter {
      name: $name,
      dateUpload: $dateUpload,
      chapterNumber: $chapterNumber,
      url: $url,
    }
    ''';
  }

  @override
  clone() {
    return Chapter()
      ..name = name
      ..dateUpload = dateUpload
      ..url = url
      ..chapterNumber = chapterNumber;
  }
}

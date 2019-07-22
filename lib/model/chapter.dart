
import 'cloneable.dart';

class Chapter implements Cloneable {
  String name;
  num dateUpload;
  String url;

  @override
  String toString() {
    return '''
    Chapter {
      name: $name,
      dateUpload: ${DateTime.fromMillisecondsSinceEpoch(dateUpload)},
      url: $url,
    }
    ''';
  }

  @override
  clone() {
    return Chapter()
      ..name = name
      ..dateUpload = dateUpload
      ..url = url;
  }
}

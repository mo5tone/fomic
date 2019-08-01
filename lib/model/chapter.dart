import 'package:fomic/common/helper/cloneable.dart';
import 'package:fomic/source/base/remote_source.dart';

class Chapter implements Cloneable {
  RemoteSource source;
  String name;
  DateTime updateAt;
  String url;
  num chapterNumber;

  @override
  String toString() {
    return '''
    Chapter {
      source: ${source.runtimeType},
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
      ..source = this.source
      ..name = name ?? this.name
      ..updateAt = updateAt ?? this.updateAt
      ..url = url ?? this.url
      ..chapterNumber = chapterNumber ?? this.chapterNumber;
  }
}

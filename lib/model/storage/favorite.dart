import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:hive/hive.dart';

class Favorite {
  Favorite._();

  static Future<bool> contains(SourceID sourceID, Book book) {
    return Hive.openBox(sourceID.boxName).then((box) => box.get(book.url) != null);
  }

  static Future<void> favorite(SourceID sourceID, Book book) {
    return contains(sourceID, book).then((value) async {
      final box = Hive.box(sourceID.boxName);
      if (value) {
        await box.delete(book.url);
      } else {
        await box.put(book.url, book.url);
      }
    });
  }
}

extension on SourceID {
  String get boxName {
    final index = SourceID.values.indexOf(this);
    return 'favorite_box_$index';
  }
}

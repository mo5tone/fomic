import 'package:flutter/foundation.dart';
import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:hive/hive.dart';

class Favorite {
  Favorite._();

  static Future<bool> contains(SourceID sourceID, Book book) {
    return Hive.openBox<Book>(sourceID.boxName).then((box) => box.values.contains(book));
  }

  static Future<void> toggle(SourceID sourceID, Book book) {
    return contains(sourceID, book).then((value) async {
      final box = Hive.box<Book>(sourceID.boxName);
      if (value) {
        await box.delete(book.hashCode);
      } else {
        await box.put(book.hashCode, book);
      }
    });
  }
}

extension on SourceID {
  String get boxName => '${describeEnum(this)}_favorite_box';
}

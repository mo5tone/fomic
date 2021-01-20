import 'package:flutter/foundation.dart';
import 'package:fomic/constant/source_id.dart';
import 'package:fomic/source/model/book.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rpFavorite = Provider((ref) => Favorite._());

class Favorite {
  Favorite._();

  Future<bool> contains(SourceId sourceID, Book book) async {
    final box = await Hive.openBox<Book>(sourceID.boxName);
    return box.values.contains(book);
  }

  Future<void> toggle(SourceId sourceID, Book book) async {
    final contains = await this.contains(sourceID, book);
    final box = Hive.box<Book>(sourceID.boxName);
    if (contains) {
      await box.delete(book.hashCode);
    } else {
      await box.put(book.hashCode, book);
    }
  }
}

extension on SourceId {
  String get boxName => '${describeEnum(this)}_favorite_box';
}

import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Book')
class Book extends Table {
  IntColumn get source => integer()();
  TextColumn get url => text()();
  TextColumn get thumbnailUrl => text().named('thumbnail_url')();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get author => text()();
  TextColumn get genre => text()();
  TextColumn get description => text()();
  IntColumn get status => integer()();

  @override
  Set<Column> get primaryKey => {source, url};
}

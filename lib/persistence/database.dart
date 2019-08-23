import 'package:fomic/sources/base/source.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart'; // run `flutter packages pub run build_runner build`

class _SimpleConverter<D, S> extends TypeConverter<D, S> {
  final D Function(S fromDb) toDart;
  final S Function(D value) toSql;

  _SimpleConverter({@required this.toDart, @required this.toSql});

  @override
  D mapToDart(S fromDb) {
    if (toDart != null) {
      return toDart(fromDb);
    }
    return null;
  }

  @override
  S mapToSql(D value) {
    if (toSql != null) {
      return toSql(value);
    }
    return null;
  }
}

final _sourceIdentityConverter = _SimpleConverter<SourceIdentity, int>(
  toDart: (value) => SourceIdentity.values[value],
  toSql: (value) => SourceIdentity.values.indexOf(value),
);

final _bookStatusConverter = _SimpleConverter<BookStatus, int>(
  toDart: (value) => BookStatus.values[value],
  toSql: (value) => BookStatus.values.indexOf(value),
);

enum BookStatus {
  unknown,
  ongoing,
  completed,
  licensed,
}

@DataClassName('Book')
class Books extends Table {
  IntColumn get sourceIdentity =>
      integer().named('source_identity').map(_sourceIdentityConverter)();

  TextColumn get url => text()();

  TextColumn get thumbnailUrl => text().nullable().named('thumbnail_url')();

  TextColumn get title => text().nullable()();

  TextColumn get artist => text().nullable()();

  TextColumn get author => text().nullable()();

  TextColumn get genre => text().nullable()();

  TextColumn get description => text().nullable()();

  IntColumn get bookStatus => integer()
      .nullable()
      .withDefault(Variable.withInt(0))
      .named('book_status')
      .map(_bookStatusConverter)();

  @override
  String get tableName => 'book';

  @override
  List<String> get customConstraints => [
        'PRIMARY KEY(source_identity, url) ON CONFLICT REPLACE',
      ];
}

@UseMoor(tables: [Books])
class Database extends _$Database {
  static final String _path = 'fomic.sqlite';
  static final Database shared = Database._();

  Database._() : super(FlutterQueryExecutor.inDatabaseFolder(path: _path));

  @override
  int get schemaVersion => 1;
}

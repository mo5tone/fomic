import 'package:fomic/model/manga_base.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:hive/hive.dart';

part 'manga.g.dart';

@HiveType(typeId: 1)
class Manga extends MangaBase {
  @HiveField(0)
  @override
  final int id;
  @HiveField(1)
  @override
  final String key;
  @HiveField(2)
  @override
  final int source;
  @HiveField(3)
  @override
  final String title;
  @HiveField(4)
  final String artist;
  @HiveField(5)
  final String author;
  @HiveField(6)
  final String description;
  @HiveField(7)
  final List<String> genres;
  @HiveField(8)
  final MangaInfoStatus status;
  @HiveField(9)
  final String cover;
  @HiveField(10)
  final String customCover;
  @HiveField(11)
  final bool favorite;
  @HiveField(12)
  final int lastUpdate;
  @HiveField(13)
  final int lastInit;
  @HiveField(14)
  final int viewer;
  @HiveField(15)
  final int flags;

  Manga(
    this.id,
    this.key,
    this.source,
    this.title, {
    this.artist = '',
    this.author = '',
    this.description = '',
    this.genres = const [],
    this.status = MangaInfoStatus.unknown,
    this.cover = '',
    this.customCover = '',
    this.favorite = false,
    this.lastUpdate = 0,
    this.lastInit = 0,
    this.viewer = 0,
    this.flags = 0,
  });
}

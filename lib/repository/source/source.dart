import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/page.dart';

abstract class Source {
  int get id;
  String get name;

  /// An ISO 639-1 compliant language code (two letters in lower case).
  String get lang;

  const Source();

  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga});
  Future<List<ChapterInfo>> fetchChapterList({required MangaInfo manga});
  Future<List<Page>> fetchPageList({required ChapterInfo chapter});
}

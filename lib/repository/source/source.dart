import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_page.dart';

abstract class Source {
  int get id;
  String get name;

  /// An ISO 639-1 compliant language code (two letters in lower case).
  String get lang;

  const Source();

  Future<SourceManga> fetchMangaDetails({required SourceManga manga});
  Future<List<SourceChapter>> fetchChapterList({required SourceManga manga});
  Future<List<SourcePage>> fetchPageList({required SourceChapter chapter});
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/source/local_source.dart';
import 'package:fomic/repository/source/online/kuai_kan_man_hua.dart';

abstract class Source {
  static final current = StateProvider((ref) => 1);
  static final provider = Provider<Source>((ref) {
    final id = ref.watch(current);
    switch (id) {
      case 1:
        return ref.read(Kuaikanmanhua.provider);
      default:
        return LocalSource();
    }
  });

  int get id;
  String get name;

  /// An ISO 639-1 compliant language code (two letters in lower case).
  String get lang;

  const Source();

  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga});
  Future<List<ChapterInfo>> fetchChapterList({required MangaInfo manga});
  Future<List<Page>> fetchPageList({required ChapterInfo chapter});
}

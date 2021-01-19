import 'package:fomic/common/constant/source_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/source/local_source.dart';
import 'package:fomic/model/source/online/bn_man_hua.dart';
import 'package:fomic/model/source/online/dmzj.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rpSource = Provider<Source>((ref) => Source.of(ref.watch(rpSourceId).state));

abstract class Source {
  SourceId get id;

  String get languageCode => id.languageCode;

  String get name => id.name;

  Future<List<Book>> fetchBooks({int page = 0, String query});

  Future<Book> fetchBook(Book book);

  Future<List<Chapter>> fetchChapters(Book book);

  Future<List<Page>> fetchPages(Chapter chapter);

  Source();

  factory Source.of(SourceId id) {
    Source source;
    switch (id) {
      case SourceId.local:
        source = LocalSource();
        break;
      case SourceId.dmzj:
        source = DMZJ();
        break;
      case SourceId.bnManHua:
        source = BNManHua();
        break;
    }
    return source;
  }
}

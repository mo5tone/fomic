import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/source/local_source.dart';
import 'package:fomic/model/source/online/bn_man_hua.dart';
import 'package:fomic/model/source/online/dmzj.dart';
import 'package:get_it/get_it.dart';

abstract class Source {
  SourceID get id;

  String get languageCode => id.languageCode;

  String get name => id.name;

  bool get moreBooks => true;

  Future<List<Book>> fetchBooks({int page = 0, String query});

  Future<Book> fetchBook(Book book);

  Future<List<Chapter>> fetchChapters(Book book);

  Future<List<Page>> fetchPages(Chapter chapter);

  Source();

  factory Source.of(SourceID id) {
    Source source;
    switch (id) {
      case SourceID.local:
        source = GetIt.I.get<LocalSource>();
        break;
      case SourceID.dmzj:
        source = GetIt.I.get<DMZJ>();
        break;
      case SourceID.bnManHua:
        source = GetIt.I.get<BNManHua>();
        break;
    }
    return source;
  }
}

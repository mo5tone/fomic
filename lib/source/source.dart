import 'package:fomic/constant/source_id.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/model/chapter.dart';
import 'package:fomic/source/model/page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './local_source.dart';
import './online_source.dart';

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

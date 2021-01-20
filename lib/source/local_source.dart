import 'package:fomic/constant/source_id.dart';
import 'package:fomic/source/model/page.dart';
import 'package:fomic/source/model/chapter.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/source.dart';

class LocalSource extends Source {
  @override
  SourceId get id => SourceId.local;

  @override
  Future<List<Book>> fetchBooks({int page = 0, String query}) {
    return Future.value([]);
  }

  @override
  Future<Book> fetchBook(Book book) {
    // TODO: implement fetchBook
    throw UnimplementedError();
  }

  @override
  Future<List<Chapter>> fetchChapters(Book book) {
    return Future.value([]);
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    return Future.value([]);
  }
}

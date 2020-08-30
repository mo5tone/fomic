import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/source/source.dart';

class LocalSource extends Source {
  @override
  SourceID get id => SourceID.local;

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

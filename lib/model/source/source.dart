import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/page.dart';

abstract class Source {
  String get languageCode => 'en';

  String get name;

  bool get hasMoreBooks => true;

  Future<List<Book>> fetchBooks({int page = 0, String query});

  Future<Book> fetchBook(Book book);

  Future<List<Chapter>> fetchChapters(Book book);

  Future<List<Page>> fetchPages(Chapter chapter);
}

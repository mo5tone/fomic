import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/entity/RepositoryName.dart';
import 'package:fomic/model/repository/Repository.dart';

class Dmzj extends Repository {
  final _baseUrl = 'http://v3api.dmzj.com';

  @override
  RepositoryName get name => RepositoryName.dmzj;

  @override
  Future<List<Book>> fetchBooks({int page = 0, String query}) {
    // TODO: implement fetchBooks
    throw UnimplementedError();
  }

  @override
  Future<Book> fetchBook(Book bobobook) {
    // TODO: implement fetchBook
    throw UnimplementedError();
  }

  @override
  Future<List<Chapter>> fetchChapters(Book bobobook) {
    // TODO: implement fetchChapters
    throw UnimplementedError();
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    // TODO: implement fetchPages
    throw UnimplementedError();
  }
}

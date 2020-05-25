import 'package:dio/dio.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/repository/Repository.dart';

class Dmzj extends Repository {
  final _baseUrl = 'http://v3api.dmzj.com';

  @override
  RepositoryName get name => RepositoryName.dmzj;

  @override
  Future<List<Book>> fetchBooks({int page = 0, String query}) {
    String path;
    RequestOptions options;
    if (query != null && query.isNotEmpty) {
      path = 'http://s.acg.dmzj.com/comicsum/search.php';
      options = RequestOptions(method: 'GET', queryParameters: {'s': query});
    } else {
      path = 'http://v2.api.dmzj.com/classify/0/1/$page.json';
      options = RequestOptions(method: 'GET');
    }
    return dio
        .request(path, options: options)
        .then((resp) => resp.data as String)
        .then(_fetchBooksParser);
  }

  @override
  Future<Book> fetchBook(Book book) {
    final path = book.url;
    final options = RequestOptions(method: 'GET', baseUrl: _baseUrl);
    return dio
        .request(path, options: options)
        .then((resp) => resp.data as String)
        .then(_fetchBookParser);
  }

  @override
  Future<List<Chapter>> fetchChapters(Book book) {
    // TODO: implement fetchChapters
    throw UnimplementedError();
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    // TODO: implement fetchPages
    throw UnimplementedError();
  }

  List<Book> _fetchBooksParser(String body) {
    // TODO: implement _fetchBooksParser
    throw UnimplementedError();
  }

  Book _fetchBookParser(String body) {
    // TODO: implement _fetchBookParser
    throw UnimplementedError();
  }
}

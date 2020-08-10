import 'package:dio/dio.dart';
import 'package:fomic/model/constant/repository_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/model/entity/page.dart';
import 'package:fomic/model/repository/bn_man_hua.dart';
import 'package:fomic/model/repository/dmzj.dart';
import 'package:get_it/get_it.dart';

abstract class Repository {
  Dio _dio;
  Dio get dio {
    _dio ??= GetIt.I.get(param1: baseOptions);
    return _dio;
  }

  RepositoryID get id;
  BaseOptions get baseOptions;
  bool get searchAll => true;

  RequestOptions booksRequest({int page = 0, String query});
  RequestOptions bookRequest(Book book);
  RequestOptions chaptersRequest(Book book);
  RequestOptions pagesRequest(Chapter chapter);

  List<Book> booksFromResponse(Response response);
  Book bookFromResponse(Response response);
  List<Chapter> chaptersFromResponse(Response response);
  List<Page> pagesFromResponse(Response response);

  Future<List<Book>> fetchBooks({int page = 0, String query}) {
    final req = booksRequest(page: page, query: query);
    return dio.request(req.path, options: req).then(booksFromResponse);
  }

  Future<Book> fetchBook(Book book) {
    final req = bookRequest(book);
    return dio.request(req.path, options: req).then(bookFromResponse).then((value) => value.merge(book));
  }

  Future<List<Chapter>> fetchChapters(Book book) {
    final req = chaptersRequest(book);
    return dio.request(req.path, options: req).then(chaptersFromResponse);
  }

  Future<List<Page>> fetchPages(Chapter chapter) {
    final req = pagesRequest(chapter);
    return dio.request(req.path, options: req).then(pagesFromResponse);
  }

  Repository();

  factory Repository.of(RepositoryID id) {
    switch (id) {
      case RepositoryID.dmzj:
        return DMZJ();
      case RepositoryID.bnmanhua:
        return BNManHua();
      default:
        return null;
    }
  }
}

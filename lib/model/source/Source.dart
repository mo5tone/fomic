import 'package:dio/dio.dart';
import 'package:fomic/model/constant/SourceID.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/model/entity/Chapter.dart';
import 'package:fomic/model/entity/Page.dart';
import 'package:fomic/model/source/BNManHua.dart';
import 'package:fomic/model/source/DMZJ.dart';
import 'package:get_it/get_it.dart';

abstract class Source {
  Dio _dio;
  Dio get dio {
    _dio ??= GetIt.I.get(param1: baseOptions);
    return _dio;
  }

  SourceID get id;
  BaseOptions get baseOptions;

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

  Source();

  factory Source.of(SourceID id) {
    switch (id) {
      case SourceID.dmzj:
        return DMZJ();
      case SourceID.bnmanhua:
        return BNManHua();
      default:
        return null;
    }
  }
}

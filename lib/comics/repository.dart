import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/source/dmzj/dmzj.dart';
import 'package:fomic/source/manhuaren/manhuaren.dart';

class ComicsRepository {
  final _sources = [
    Dmzj(),
    Manhuaren(),
  ];

  ComicsRepository._();

  static final ComicsRepository _instance = ComicsRepository._();

  factory ComicsRepository() => _instance;

  Future<List<Comic>> fetchComics({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  }) {
    return Future.wait(_sources.map((source) =>
            source.fetchComics(page: page, query: query, filters: filters)))
        .then((futures) =>
            futures.reduce((value, element) => [...?value, ...?element]));
  }
}

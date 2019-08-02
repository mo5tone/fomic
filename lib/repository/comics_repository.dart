import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/source/base/remote_source.dart';
import 'package:fomic/source/source_id.dart';

class ComicsRepository {
  ComicsRepository._();

  static final ComicsRepository _instance = ComicsRepository._();

  factory ComicsRepository() => _instance;

  Future<List<Comic>> fetchComics({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
    List<SourceID> ids,
  }) {
    var sources = [
      SourceID.dmzj,
      SourceID.manhuaren,
    ].map((id) => RemoteSource.of(id));
    if (ids != null) {
      sources = sources
          .where((source) => ids.contains(source.id))
          .toList(growable: false);
    }
    return Future.wait(sources.map((source) =>
            source.fetchComics(page: page, query: query, filters: filters)))
        .then((futures) =>
            futures.reduce((value, element) => [...?value, ...?element]));
  }
}

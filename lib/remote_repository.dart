import 'model/comic.dart';
import 'source/base/remote_source.dart';

class RemoteRepository {
  final List<RemoteSource> sources;

  RemoteRepository(this.sources);

  Future<List<Comic>> fetchComics() {
    return Future.wait(sources.map((source) => source.fetchComics())).then(
        (comics) =>
            comics.reduce((value, element) => [...?value, ...?element]));
  }

  void close() {
    sources.forEach((source) {
      source.close();
    });
  }
}

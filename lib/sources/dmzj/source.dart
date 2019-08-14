import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/online//json_source.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/dmzj/filter.dart';

class Dmzj extends JsonSource {
  @override
  SourceId get id => SourceId.dmzj;

  @override
  String get name => '动漫之家';

  @override
  List<Filter> get filters => [
        GenreFilter(),
        StatusFilter(),
        TypeFilter(),
        SortFilter(),
        ReaderFilter(),
      ];

  @override
  String get baseUrl => 'http://v2.api.dmzj.com';

  @override
  BaseOptions get baseOptions => super.baseOptions.merge(
        headers: {
          'User-Agent': [
            'Mozilla/5.0 (X11; Linux x86_64)',
            'AppleWebKit/537.36 (KHTML, like Gecko)',
            'Chrome/56.0.2924.87',
            'Safari/537.36',
            'Fomic/1.0',
          ].join(' '),
        },
      );

  Dmzj._();

  static final Dmzj _instance = Dmzj._();

  factory Dmzj() => _instance;

  @override
  Future<List<Manga>> fetchMangaList({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  }) {
    return _MangaListFetcher(this, page, query, filters).fetch();
  }

  @override
  Future<Manga> fetchManga(Manga manga) {
    return _MangaFetcher(this, manga).fetch();
  }

  @override
  Future<List<Chapter>> fetchChapterList(Manga manga) {
    return _ChapterListFetcher(this, manga).fetch();
  }

  @override
  Future<Pair<Manga, List<Chapter>>> fetchMangaAndChapterList(Manga manga) {
    return _MangaAndChapterListFetcher(this, manga).fetch();
  }

  @override
  Future<List<Page>> fetchPageList(Chapter chapter) {
    return _PageListFetcher(this, chapter).fetch();
  }
}

class _MangaListFetcher extends Fetcher<List<Manga>> {
  final int page;
  final String query;
  final List<Filter> filters;

  _MangaListFetcher(OnlineSource source, this.page, this.query, this.filters)
      : super(source);

  List<Manga> _onSuccessQuery(Response response) {
    String data = response.data;
    var regExp = RegExp(r'g_search_data = (.*);');
    var match = regExp.firstMatch(data);
    if (match == null) {
      return [];
    }
    List array = convert.jsonDecode(match.group(1));
    return array.map((obj) {
      MangaStatus status;
      switch (obj['status_tag_id'] as String) {
        case '2310':
          status = MangaStatus.completed;
          break;
        case '2309':
          status = MangaStatus.ongoing;
          break;
        default:
          status = MangaStatus.unknown;
          break;
      }
      return Manga(
        sourceId: source.id,
        url: '/comic/${obj['id']}.json',
        title: obj['name'],
        author: obj['authors'],
        thumbnailUrl: utils.fixScheme(obj['cover']),
        status: status,
        description: obj['description'],
      );
    }).toList();
  }

  List<Manga> _onSuccessFilters(Response response) {
    List array = response.data;
    return array.map((obj) {
      MangaStatus status;
      switch (obj['status'] as String) {
        case '已完结':
          status = MangaStatus.completed;
          break;
        case '连载中':
          status = MangaStatus.ongoing;
          break;
        default:
          status = MangaStatus.unknown;
          break;
      }
      return Manga(
        sourceId: source.id,
        url: '/comic/${obj['id']}.json',
        title: obj['title'],
        author: obj['authors'],
        thumbnailUrl: utils.fixScheme(obj['cover']),
        status: status,
        description: obj['description'],
      );
    }).toList();
  }

  @override
  List<Manga> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Manga> onSuccess(Response response) {
    if (response.data is String) {
      return _onSuccessQuery(response);
    }
    return _onSuccessFilters(response);
  }

  @override
  RequestOptions get requestOptions {
    var path = '';
    var responseType = ResponseType.json;
    var queryParameters = <String, dynamic>{};
    if (query.isNotEmpty) {
      path = 'http://s.acg.dmzj.com/comicsum/search.php';
      responseType = ResponseType.plain;
      queryParameters['s'] = query;
    } else {
      var params = filters
          .where((filter) => filter is! SortFilter)
          .map((filter) => filter as SelectableFilter)
          .map((filter) => filter.value)
          .where((value) => value.isNotEmpty)
          .join('-');
      if (params.isEmpty) {
        params = '0';
      }
      var order = filters
          .where((filter) => filter is SortFilter)
          .map((filter) => filter as SelectableFilter)
          .map((filter) => filter.value)
          .join();
      if (order.isEmpty) {
        order = '0';
      }
      path = '/classify/$params/$order/$page.json';
      responseType = ResponseType.json;
    }
    return RequestOptions(
      path: path,
      queryParameters: queryParameters,
      responseType: responseType,
    );
  }
}

class _MangaFetcher extends Fetcher<Manga> {
  final Manga manga;

  _MangaFetcher(OnlineSource source, this.manga)
      : assert(manga != null),
        super(source);

  @override
  Manga onFailure(Object error, StackTrace stackTrace) {
    return null;
  }

  @override
  Manga onSuccess(Response response) {
    Map obj = response.data;
    MangaStatus status;
    switch (obj['status'][0]['tag_id'] as int) {
      case 2310:
        status = MangaStatus.completed;
        break;
      case 2309:
        status = MangaStatus.ongoing;
        break;
      default:
        status = MangaStatus.unknown;
        break;
    }
    return manga.clone(
      title: obj['title'],
      thumbnailUrl: obj['cover'],
      author: obj['authors'].map((sub) => sub['tag_name']).join(', '),
      genre: obj['types'].map((sub) => sub['tag_name']).join(', '),
      status: status,
      description: obj['description'],
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: manga.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _ChapterListFetcher extends Fetcher<List<Chapter>> {
  final Manga manga;

  _ChapterListFetcher(OnlineSource source, this.manga)
      : assert(manga != null),
        super(source);

  @override
  List<Chapter> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Chapter> onSuccess(Response response) {
    Map obj = response.data;
    final id = obj['id'];
    var chapters = <Chapter>[];
    for (final item0 in obj['chapters']) {
      String prefix = item0['title'];
      List data = item0['data'];
      for (final item1 in data) {
        chapters.add(Chapter(
          manga: manga,
          name: '$prefix: ${item1['chapter_title']}',
          updateAt:
              DateTime.fromMillisecondsSinceEpoch(item1['updatetime'] * 1000),
          url: '/chapter/$id/${item1["chapter_id"]}.json',
        ));
      }
    }
    return chapters;
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: manga.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _MangaAndChapterListFetcher extends Fetcher<Pair<Manga, List<Chapter>>> {
  final Manga manga;

  _MangaAndChapterListFetcher(OnlineSource source, this.manga)
      : assert(manga != null),
        super(source);

  @override
  Pair<Manga, List<Chapter>> onFailure(Object error, StackTrace stackTrace) {
    return null;
  }

  @override
  Pair<Manga, List<Chapter>> onSuccess(Response response) {
    final Map obj = response.data;
    MangaStatus status;
    switch (obj['status'][0]['tag_id'] as int) {
      case 2310:
        status = MangaStatus.completed;
        break;
      case 2309:
        status = MangaStatus.ongoing;
        break;
      default:
        status = MangaStatus.unknown;
        break;
    }
    final manga = this.manga.clone(
          title: obj['title'],
          thumbnailUrl: obj['cover'],
          author: obj['authors'].map((sub) => sub['tag_name']).join(', '),
          genre: obj['types'].map((sub) => sub['tag_name']).join(', '),
          status: status,
          description: obj['description'],
        );
    final id = obj['id'];
    final chapterList = <Chapter>[];
    (obj['chapters'] as List).forEach((chaptersItem) {
      final String prefix = chaptersItem['title'];
      (chaptersItem['data'] as List).forEach((dataItem) {
        final updateAt =
            DateTime.fromMillisecondsSinceEpoch(dataItem['updatetime'] * 1000);
        chapterList.add(Chapter(
          manga: manga,
          name: '$prefix: ${dataItem['chapter_title']}',
          updateAt: updateAt,
          url: '/chapter/$id/${dataItem["chapter_id"]}.json',
        ));
      });
    });
    return Pair(manga, chapterList);
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: manga.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _PageListFetcher extends Fetcher<List<Page>> {
  final Chapter chapter;

  _PageListFetcher(OnlineSource source, this.chapter)
      : assert(chapter != null),
        super(source);

  @override
  List<Page> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Page> onSuccess(Response response) {
    List array = response.data['page_url'];
    var index = 0;

    return array
        .map((obj) => Page(
              chapter: chapter,
              index: index++,
              url: '',
              imageUrl: obj,
            ))
        .toList();
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: chapter.url);
}

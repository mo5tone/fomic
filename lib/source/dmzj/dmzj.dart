import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/source/base/api_source.dart';
import 'package:fomic/source/base/remote_source.dart';
import 'package:fomic/source/dmzj/filter.dart';

class Dmzj extends ApiSource {
  @override
  String get name => '动漫之家';

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
  Future<List<Comic>> fetchComics(
      {int page = 0, String query = '', List<Filter> filters = const []}) {
    var fetcher =
        _ComicsFetcher(client, page: page, query: query, filters: filters);
    return fetcher.fetch();
  }

  @override
  Future<Comic> fetchComic(Comic comic) {
    var fetcher = _ComicFetcher(client, comic: comic);
    return fetcher.fetch();
  }

  @override
  Future<List<Chapter>> fetchChapters(Comic comic) {
    var fetcher = _ChaptersFetcher(client, comic: comic);
    return fetcher.fetch();
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    var fetcher = _PagesFetcher(client, chapter: chapter);
    return fetcher.fetch();
  }
}

class _ComicsFetcher extends Fetcher<List<Comic>> {
  final int page;
  final String query;
  final List<Filter> filters;

  _ComicsFetcher(Dio client,
      {this.page = 0,
      this.query = '',
      this.filters = const [],
      List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

  List<Comic> _onSearchSuccess(Response response) {
    String data = response.data;
    var regExp = RegExp(r'g_search_data = (.*);');
    var match = regExp.firstMatch(data);
    if (match == null) {
      return [];
    }
    List array = convert.jsonDecode(match.group(1));
    return array.map((obj) {
      ComicStatus status;
      switch (obj['status_tag_id'] as String) {
        case '2310':
          status = ComicStatus.completed;
          break;
        case '2309':
          status = ComicStatus.ongoing;
          break;
        default:
          status = ComicStatus.unknown;
          break;
      }
      return Comic()
        ..source = Dmzj()
        ..url = '/comic/${obj['id']}.json'
        ..title = obj['name']
        ..author = obj['authors']
        ..thumbnailUrl = utils.fixScheme(obj['cover'])
        ..comicStatus = status
        ..description = obj['description'];
    }).toList();
  }

  @override
  List<Comic> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Comic> onSuccess(Response response) {
    if (response.data is String) {
      return _onSearchSuccess(response);
    }
    List array = response.data;
    return array.map((obj) {
      ComicStatus status;
      switch (obj['status'] as String) {
        case '已完结':
          status = ComicStatus.completed;
          break;
        case '连载中':
          status = ComicStatus.ongoing;
          break;
        default:
          status = ComicStatus.unknown;
          break;
      }
      return Comic()
        ..source = Dmzj()
        ..url = '/comic/${obj['id']}.json'
        ..title = obj['title']
        ..author = obj['authors']
        ..thumbnailUrl = utils.fixScheme(obj['cover'])
        ..comicStatus = status
        ..description = obj['description'];
    }).toList();
  }

  @override
  RequestOptions get requestOptions {
    var path = '';
    var queryParameters = <String, dynamic>{};
    if (query.isNotEmpty) {
      path = 'http://s.acg.dmzj.com/comicsum/search.php';
      queryParameters['s'] = query;
    } else {
      var params = filters
          .where((filter) => !(filter is SortFilter))
          .map((filter) => filter.value)
          .where((value) => (value is String) && value.isNotEmpty)
          .join('-');
      if (params.isEmpty) {
        params = '0';
      }
      var order = filters
          .where((filter) => filter is SortFilter)
          .map((filter) => filter.value)
          .join();
      if (order.isEmpty) {
        order = '0';
      }
      path = '/classify/$params/$order/$page.json';
    }
    return RequestOptions(
        path: path,
        queryParameters: queryParameters,
        responseType:
            path.startsWith('http') ? ResponseType.plain : ResponseType.json);
  }
}

class _ComicFetcher extends Fetcher<Comic> {
  final Comic comic;

  _ComicFetcher(Dio client, {@required this.comic, List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

  @override
  Comic onFailure(Object error, StackTrace stackTrace) {
    return null;
  }

  @override
  Comic onSuccess(Response response) {
    Map obj = response.data;
    ComicStatus status;
    switch (obj['status'][0]['tag_id'] as int) {
      case 2310:
        status = ComicStatus.completed;
        break;
      case 2309:
        status = ComicStatus.ongoing;
        break;
      default:
        status = ComicStatus.unknown;
        break;
    }
    return comic.clone(
      title: obj['title'],
      thumbnailUrl: obj['cover'],
      author: obj['authors'].map((sub) => sub['tag_name']).join(', '),
      genre: obj['types'].map((sub) => sub['tag_name']).join(', '),
      comicStatus: status,
      description: obj['description'],
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: comic.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _ChaptersFetcher extends Fetcher<List<Chapter>> {
  final Comic comic;

  _ChaptersFetcher(Dio client, {@required this.comic, List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

  @override
  List<Chapter> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Chapter> onSuccess(Response response) {
    var obj = response.data;
    var id = obj['id'];
    var chapters = <Chapter>[];
    for (var item0 in obj['chapters']) {
      String prefix = item0['title'];
      List data = item0['data'];
      for (var item1 in data) {
        chapters.add(Chapter()
          ..name = '$prefix: ${item1['chapter_title']}'
          ..updateAt =
              DateTime.fromMillisecondsSinceEpoch(item1['updatetime'] * 1000)
          ..url = '/chapter/$id/${item1["chapter_id"]}.json');
      }
    }
    return chapters;
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: comic.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _PagesFetcher extends Fetcher<List<Page>> {
  final Chapter chapter;

  _PagesFetcher(Dio client, {@required this.chapter, List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

  @override
  List<Page> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Page> onSuccess(Response response) {
    List array = response.data['page_url'];
    var index = 0;
    return array.map((obj) => Page(index++, '', imageUrl: obj)).toList();
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: chapter.url);
}

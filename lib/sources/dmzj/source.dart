import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
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
        GenreFilter('分类', [
          Pair('全部', ''),
          Pair('冒险', '4'),
          Pair('百合', '3243'),
          Pair('生活', '3242'),
          Pair('四格', '17'),
          Pair('伪娘', '3244'),
          Pair('悬疑', '3245'),
          Pair('后宫', '3249'),
          Pair('热血', '3248'),
          Pair('耽美', '3246'),
          Pair('其他', '16'),
          Pair('恐怖', '14'),
          Pair('科幻', '7'),
          Pair('格斗', '6'),
          Pair('欢乐向', '5'),
          Pair('爱情', '8'),
          Pair('侦探', '9'),
          Pair('校园', '13'),
          Pair('神鬼', '12'),
          Pair('魔法', '11'),
          Pair('竞技', '10'),
          Pair('历史', '3250'),
          Pair('战争', '3251'),
          Pair('魔幻', '5806'),
          Pair('扶她', '5345'),
          Pair('东方', '5077'),
          Pair('奇幻', '5848'),
          Pair('轻小说', '6316'),
          Pair('仙侠', '7900'),
          Pair('搞笑', '7568'),
          Pair('颜艺', '6437'),
          Pair('性转换', '4518'),
          Pair('高清单行', '4459'),
          Pair('治愈', '3254'),
          Pair('宅系', '3253'),
          Pair('萌系', '3252'),
          Pair('励志', '3255'),
          Pair('节操', '6219'),
          Pair('职场', '3328'),
          Pair('西方魔幻', '3365'),
          Pair('音乐舞蹈', '3326'),
          Pair('机战', '3325'),
        ]),
        StatusFilter('连载状态', [
          Pair('全部', ''),
          Pair('连载', '2309'),
          Pair('完结', '2310'),
        ]),
        TypeFilter('地区', [
          Pair('全部', ''),
          Pair('日本', '2304'),
          Pair('韩国', '2305'),
          Pair('欧美', '2306'),
          Pair('港台', '2307'),
          Pair('内地', '2308'),
          Pair('其他', '8453'),
        ]),
        SortFilter('排序', [
          Pair('人气', '0'),
          Pair('更新', '1'),
        ]),
        ReaderFilter('读者', [
          Pair('全部', ''),
          Pair('少年', '3262'),
          Pair('少女', '3263'),
          Pair('青年', '3264'),
        ]),
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
  Future<List<Comic>> fetchComics({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  }) {
    return _ComicsFetcher(
      client,
      page: page,
      query: query,
      filters: filters,
    ).fetch();
  }

  @override
  Future<Comic> fetchComic(Comic comic) =>
      _ComicFetcher(client, comic: comic).fetch();

  @override
  Future<List<Chapter>> fetchChapters(Comic comic) =>
      _ChaptersFetcher(client, comic: comic).fetch();

  @override
  Future<List<Page>> fetchPages(Chapter chapter) =>
      _PagesFetcher(client, chapter: chapter).fetch();
}

class _ComicsFetcher extends Fetcher<List<Comic>> {
  final int page;
  final String query;
  final List<Filter> filters;

  _ComicsFetcher(
    Dio client, {
    this.page = 0,
    this.query = '',
    this.filters = const [],
  }) : super(client);

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
        ..status = status
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
        ..status = status
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

  _ComicFetcher(
    Dio client, {
    @required this.comic,
  })  : assert(comic != null),
        super(client);

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
      status: status,
      description: obj['description'],
      chapters: _ChaptersFetcher(client, comic: comic).onSuccess(response),
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: comic.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _ChaptersFetcher extends Fetcher<List<Chapter>> {
  final Comic comic;

  _ChaptersFetcher(
    Dio client, {
    @required this.comic,
  })  : assert(comic != null),
        super(client);

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
        chapters.add(Chapter()
          ..source = Dmzj()
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

  _PagesFetcher(
    Dio client, {
    @required this.chapter,
  })  : assert(chapter != null),
        super(client);

  @override
  List<Page> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Page> onSuccess(Response response) {
    List array = response.data['page_url'];
    var index = 0;

    return array
        .map((obj) => Page()
          ..source = Dmzj()
          ..index = index++
          ..url = ''
          ..imageUrl = obj)
        .toList();
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: chapter.url);
}

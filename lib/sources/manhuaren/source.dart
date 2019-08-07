import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/helper/triplet.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/remote/api_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/manhuaren//filter.dart';

class Manhuaren extends ApiSource {
  @override
  SourceId get id => SourceId.manhuaren;

  @override
  String get name => '漫画人';

  @override
  List<Filter> get filters => [
        SortFilter('状态', [
          Pair('热门', '0'),
          Pair('更新', '1'),
          Pair('新作', '2'),
          Pair('完结', '3'),
        ]),
        CategoryFilter('分类', [
          Triplet('全部', '0', '0'),
          Triplet('热血', '0', '31'),
          Triplet('恋爱', '0', '26'),
          Triplet('校园', '0', '1'),
          Triplet('百合', '0', '3'),
          Triplet('耽美', '0', '27'),
          Triplet('伪娘', '0', '5'),
          Triplet('冒险', '0', '2'),
          Triplet('职场', '0', '6'),
          Triplet('后宫', '0', '8'),
          Triplet('治愈', '0', '9'),
          Triplet('科幻', '0', '25'),
          Triplet('励志', '0', '10'),
          Triplet('生活', '0', '11'),
          Triplet('战争', '0', '12'),
          Triplet('悬疑', '0', '17'),
          Triplet('推理', '0', '33'),
          Triplet('搞笑', '0', '37'),
          Triplet('奇幻', '0', '14'),
          Triplet('魔法', '0', '15'),
          Triplet('恐怖', '0', '29'),
          Triplet('神鬼', '0', '20'),
          Triplet('萌系', '0', '21'),
          Triplet('历史', '0', '4'),
          Triplet('美食', '0', '7'),
          Triplet('同人', '0', '30'),
          Triplet('运动', '0', '34'),
          Triplet('绅士', '0', '36'),
          Triplet('机甲', '0', '40'),
          Triplet('限制级', '0', '61'),
          Triplet('少年向', '1', '1'),
          Triplet('少女向', '1', '2'),
          Triplet('青年向', '1', '3'),
          Triplet('港台', '2', '35'),
          Triplet('日韩', '2', '36'),
          Triplet('大陆', '2', '37'),
          Triplet('欧美', '2', '52'),
        ]),
      ];

  @override
  String get baseUrl => 'http://mangaapi.manhuaren.com';

  @override
  BaseOptions get baseOptions => super.baseOptions.merge(
        headers: headers,
      );

  static const pageSize = 20;

  static const headers = {
    'X-Yq-Yqci': '{\"le\": \"zh\"}',
    'User-Agent': 'okhttp/3.11.0',
    'Referer': 'http://www.dm5.com/dm5api/',
    'clubReferer': 'http://mangaapi.manhuaren.com/',
  };

  @override
  List<InterceptorsWrapper> get interceptors => [
        InterceptorsWrapper(
          onRequest: (requestOptions) {
            var queryParameters = Map.of(requestOptions.uri.queryParameters);
            queryParameters.addAll({
              'gsm': 'md5',
              'gft': 'json',
              'gts':
                  utils.dateTime2String(DateTime.now(), 'yyyy-MM-dd+HH:mm:ss'),
              'gak': 'android_manhuaren2',
              'gat': '',
              'gaui': '191909801',
              'gui': '191909801',
              'gut': '0',
            });
            queryParameters.addAll({'gsn': _gsnHash(queryParameters)});
            var keysToRemove = ['mangaId', 'mangaSectionId'];
            queryParameters
                .removeWhere((key, value) => keysToRemove.contains(key));
            requestOptions.queryParameters = queryParameters;
            return requestOptions;
          },
          onResponse: (response) {
            if (response.data.containsKey('errorResponse')) {
              throw DioError(
                  request: response.request,
                  response: response,
                  message: response.data['errorResponse']['message']);
            }
          },
        ),
      ];

  Manhuaren._();

  static final Manhuaren _instance = Manhuaren._();

  factory Manhuaren() => _instance;

  String _gsnHash(Map<String, dynamic> queryParameters) {
    String cipher = '4e0a48e1c0b54041bce9c8f0e036124d';
    var str = cipher + 'GET';
    var keys = queryParameters.keys.where((key) => key != 'gsn').toList()
      ..sort((a, b) => a.compareTo(b));
    str += keys.map((key) {
      var parameter = queryParameters[key];
      String value;
      if (parameter is List<String>) {
        value = parameter.first;
      } else {
        value = '$parameter';
      }
      value = Uri.encodeQueryComponent(value)
        ..replaceAll('+', '%20')
        ..replaceAll('%7E', '~')
        ..replaceAll('*', '%2A');
      return key + value;
    }).join();
    str += cipher;
    return utils.md5(str);
  }

  @override
  Future<List<Comic>> fetchComics({int page = 0, String query = ''}) {
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

  @override
  List<Comic> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Comic> onSuccess(Response response) {
    Map json = response.data;
    Map obj = json['response'];
    List array = (obj['result'] ?? obj['mangas']);
    return array
        .map((obj) => Comic()
          ..source = Manhuaren()
          ..url = '/v1/manga/getDetail?mangaId=${obj['mangaId']}'
          ..title = obj['mangaName']
          ..author = obj['mangaAuthor']
          ..status = obj['mangaIsOver'] == 0
              ? ComicStatus.ongoing
              : (obj['mangaIsOver'] == 1
                  ? ComicStatus.completed
                  : ComicStatus.unknown)
          ..thumbnailUrl = obj['mangaCoverimageUrl'])
        .toList();
  }

  @override
  RequestOptions get requestOptions {
    var path = '';
    var queryParameters = {
      'start': '${Manhuaren.pageSize * page}',
      'limit': '${Manhuaren.pageSize}',
    };
    if (query.isNotEmpty) {
      path = '/v1/search/getSearchManga';
      queryParameters['keywords'] = query;
    } else {
      path = '/v2/manga/getCategoryMangas';
      filters.forEach((filter) {
        if (filter is SortFilter) {
          queryParameters['sort'] = filter.value;
        } else if (filter is CategoryFilter) {
          queryParameters['subCategoryId'] = filter.id;
          queryParameters['subCategoryType'] = filter.type;
        }
      });
      queryParameters['sort'] ??= '0';
      queryParameters['subCategoryType'] ??= '0';
      queryParameters['subCategoryId'] ??= '0';
    }
    return RequestOptions(path: path, queryParameters: queryParameters);
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
    Map obj = response.data['response'];
    String thumbnailUrl = obj['mangaCoverimageUrl'] ?? '';
    if (thumbnailUrl.isEmpty) {
      thumbnailUrl = obj['mangaPicimageUrl'] ?? '';
      if (thumbnailUrl.isEmpty) {
        thumbnailUrl = obj['shareIcon'] ?? '';
      }
    }
    ComicStatus status;
    switch (obj['mangaIsOver'] as int) {
      case 1:
        status = ComicStatus.completed;
        break;
      case 0:
        status = ComicStatus.ongoing;
        break;
      default:
        status = ComicStatus.unknown;
        break;
    }
    return comic.clone(
      title: obj['mangaName'],
      thumbnailUrl: thumbnailUrl,
      author: obj['mangaAuthors'].join(', '),
      genre: obj['mangaTheme'].replaceAll(' ', ', '),
      status: status,
      description: obj['mangaIntro'],
      chapters: _ChaptersFetcher(client, comic: comic).onSuccess(response),
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: comic.url);
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
    Map obj = response.data['response'];
    var chapters = <Chapter>[];
    ['mangaEpisode', 'mangaWords', 'mangaRolls'].forEach((type) {
      List array = obj[type];
      if (array != null) {
        chapters.addAll(array.map((item) => Chapter()
          ..source = Manhuaren()
          ..name =
              '${type == 'mangaEpisode' ? '【番外】' : ''}${item['sectionName']}${item['sectionTitle'] == '' ? '' : '：${item['sectionTitle']}'}'
          ..updateAt = utils.string2DateTime(item['releaseTime'], 'yyyy-MM-dd')
          ..chapterNumber = item['sectionSort']
          ..url = '/v1/manga/getRead?mangaSectionId=${item["sectionId"]}'));
      }
    });
    return chapters;
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: comic.url);
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
    Map obj = response.data['response'];
    String host = obj['hostList'][0];
    List array = obj['mangaSectionImages'];
    String query = obj['query'];
    var index = 0;
    return array
        .map((item) => Page()
          ..source = Manhuaren()
          ..index = index++
          ..url = '$host$item$query'
          ..imageUrl = '$host$item$query'
          ..headers = Manhuaren.headers)
        .toList();
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: chapter.url,
      queryParameters: {'netType': '4', 'loadreal': '1', 'imageQuality': '2'});
}

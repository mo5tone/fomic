import 'package:dio/dio.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/online/json_source.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/manhuaren//filter.dart';

class Manhuaren extends JsonSource {
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
          Pair('全部', Pair('0', '0')),
          Pair('热血', Pair('0', '31')),
          Pair('恋爱', Pair('0', '26')),
          Pair('校园', Pair('0', '1')),
          Pair('百合', Pair('0', '3')),
          Pair('耽美', Pair('0', '27')),
          Pair('伪娘', Pair('0', '5')),
          Pair('冒险', Pair('0', '2')),
          Pair('职场', Pair('0', '6')),
          Pair('后宫', Pair('0', '8')),
          Pair('治愈', Pair('0', '9')),
          Pair('科幻', Pair('0', '25')),
          Pair('励志', Pair('0', '10')),
          Pair('生活', Pair('0', '11')),
          Pair('战争', Pair('0', '12')),
          Pair('悬疑', Pair('0', '17')),
          Pair('推理', Pair('0', '33')),
          Pair('搞笑', Pair('0', '37')),
          Pair('奇幻', Pair('0', '14')),
          Pair('魔法', Pair('0', '15')),
          Pair('恐怖', Pair('0', '29')),
          Pair('神鬼', Pair('0', '20')),
          Pair('萌系', Pair('0', '21')),
          Pair('历史', Pair('0', '4')),
          Pair('美食', Pair('0', '7')),
          Pair('同人', Pair('0', '30')),
          Pair('运动', Pair('0', '34')),
          Pair('绅士', Pair('0', '36')),
          Pair('机甲', Pair('0', '40')),
          Pair('限制级', Pair('0', '61')),
          Pair('少年向', Pair('1', '1')),
          Pair('少女向', Pair('1', '2')),
          Pair('青年向', Pair('1', '3')),
          Pair('港台', Pair('2', '35')),
          Pair('日韩', Pair('2', '36')),
          Pair('大陆', Pair('2', '37')),
          Pair('欧美', Pair('2', '52')),
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
  Future<List<Manga>> fetchMangaList({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  }) {
    return _MangaListFetcher(
      this,
      page: page,
      query: query,
      filters: filters,
    ).fetch();
  }

  @override
  Future<Manga> fetchManga(Manga manga) =>
      _MangaFetcher(this, manga: manga).fetch();

  @override
  Future<List<Chapter>> fetchChapterList(Manga manga) =>
      _ChaptersFetcher(this, manga: manga).fetch();

  @override
  Future<List<Page>> fetchPageList(Chapter chapter) =>
      _PagesFetcher(this, chapter: chapter).fetch();
}

class _MangaListFetcher extends Fetcher<List<Manga>> {
  final int page;
  final String query;
  final List<Filter> filters;

  _MangaListFetcher(
    OnlineSource source, {
    this.page = 0,
    this.query = '',
    this.filters = const [],
  }) : super(source);

  @override
  List<Manga> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Manga> onSuccess(Response response) {
    Map json = response.data;
    Map obj = json['response'];
    List array = (obj['result'] ?? obj['mangas']);
    return array.map((obj) {
      final status = obj['mangaIsOver'] == 0
          ? MangaStatus.ongoing
          : (obj['mangaIsOver'] == 1
              ? MangaStatus.completed
              : MangaStatus.unknown);
      return Manga(
        sourceId: source.id,
        url: '/v1/manga/getDetail?mangaId=${obj['mangaId']}',
        title: obj['mangaName'],
        author: obj['mangaAuthor'],
        status: status,
        thumbnailUrl: obj['mangaCoverimageUrl'],
      );
    }).toList();
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

class _MangaFetcher extends Fetcher<Manga> {
  final Manga manga;

  _MangaFetcher(OnlineSource source, {this.manga}) : super(source);

  @override
  Manga onFailure(Object error, StackTrace stackTrace) {
    return null;
  }

  @override
  Manga onSuccess(Response response) {
    Map obj = response.data['response'];
    String thumbnailUrl = obj['mangaCoverimageUrl'] ?? '';
    if (thumbnailUrl.isEmpty) {
      thumbnailUrl = obj['mangaPicimageUrl'] ?? '';
      if (thumbnailUrl.isEmpty) {
        thumbnailUrl = obj['shareIcon'] ?? '';
      }
    }
    MangaStatus status;
    switch (obj['mangaIsOver'] as int) {
      case 1:
        status = MangaStatus.completed;
        break;
      case 0:
        status = MangaStatus.ongoing;
        break;
      default:
        status = MangaStatus.unknown;
        break;
    }
    return manga.clone(
      title: obj['mangaName'],
      thumbnailUrl: thumbnailUrl,
      author: obj['mangaAuthors'].join(', '),
      genre: obj['mangaTheme'].replaceAll(' ', ', '),
      status: status,
      description: obj['mangaIntro'],
      chapters: _ChaptersFetcher(source, manga: manga).onSuccess(response),
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: manga.url);
}

class _ChaptersFetcher extends Fetcher<List<Chapter>> {
  final Manga manga;

  _ChaptersFetcher(OnlineSource source, {this.manga}) : super(source);

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
      if (array == null) {
        return;
      }
      chapters.addAll(array.map((item) {
        final prefix = '${type == 'mangaEpisode' ? '【番外】' : ''}';
        final title =
            item['sectionTitle'] == '' ? '' : '：${item['sectionTitle']}';
        final name = '$prefix${item['sectionName']}$title';
        return Chapter(
          sourceId: SourceId.manhuaren,
          name: name,
          updateAt: utils.string2DateTime(item['releaseTime'], 'yyyy-MM-dd'),
          chapterNumber: item['sectionSort'],
          url: '/v1/manga/getRead?mangaSectionId=${item["sectionId"]}',
        );
      }));
    });
    return chapters;
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: manga.url);
}

class _PagesFetcher extends Fetcher<List<Page>> {
  final Chapter chapter;

  _PagesFetcher(OnlineSource source, {this.chapter}) : super(source);

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
        .map((item) => Page(
              sourceId: SourceId.manhuaren,
              index: index++,
              url: '$host$item$query',
              imageUrl: '$host$item$query',
              headers: Manhuaren.headers,
            ))
        .toList();
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: chapter.url,
      queryParameters: {'netType': '4', 'loadreal': '1', 'imageQuality': '2'});
}

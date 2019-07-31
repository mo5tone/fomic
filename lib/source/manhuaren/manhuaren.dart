import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/source/base/api_source.dart';
import 'package:fomic/source/base/remote_source.dart';
import 'package:fomic/source/manhuaren/filter.dart';

class Manhuaren extends ApiSource {
  @override
  String get name => '漫画人';

  @override
  String get baseUrl => 'http://mangaapi.manhuaren.com';

  @override
  BaseOptions get baseOptions => super.baseOptions.merge(
        headers: {
          'X-Yq-Yqci': '{\"le\": \"zh\"}',
          'User-Agent': 'okhttp/3.11.0',
          'Referer': 'http://www.dm5.com/dm5api/',
          'clubReferer': 'http://mangaapi.manhuaren.com/',
        },
      );

  Manhuaren._();

  static final Manhuaren _instance = Manhuaren._();

  factory Manhuaren() => _instance;

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
  static const pageSize = 20;

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
      {this.page, this.query, this.filters, List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

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
          ..comicStatus = obj['mangaIsOver'] == 0
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
          queryParameters['subCategoryId'] = filter.value.second;
          queryParameters['subCategoryType'] = filter.value.first;
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

  _ComicFetcher(Dio client, {@required this.comic, List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

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
      comicStatus: status,
      description: obj['mangaIntro'],
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: comic.url);
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
    Map obj = response.data['response'];
    var chapters = <Chapter>[];
    ['mangaEpisode', 'mangaWords', 'mangaRolls'].forEach((type) {
      List array = obj[type];
      if (array != null) {
        chapters.addAll(array.map((item) => Chapter()
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

  _PagesFetcher(Dio client, {@required this.chapter, List<Type> errorTypes})
      : super(client, errorTypes: errorTypes);

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
        .map((item) =>
            Page(index++, '$host$item$query', imageUrl: '$host$item$query'))
        .toList();
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: chapter.url,
      queryParameters: {'netType': '4', 'loadreal': '1', 'imageQuality': '2'});
}

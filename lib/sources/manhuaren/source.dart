import 'package:dio/dio.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/book.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/sources/base/online/json_source.dart';
import 'package:fomic/sources/base/online_source.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/sources/manhuaren//filter.dart';

class Manhuaren extends JsonSource {
  @override
  SourceIdentity get identity => SourceIdentity.manhuaren;

  @override
  String get name => '漫画人';

  @override
  List<Filter> get filters => [
        SortFilter(),
        CategoryFilter(),
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
  Future<List<Book>> fetchBooks({
    int page = 0,
    String query = '',
    List<Filter> filters = const [],
  }) {
    return _BooksFetcher(this, page, query, filters).fetch();
  }

  @override
  Future<Book> fetchBook(Book book) {
    return _BookFetcher(this, book).fetch();
  }

  @override
  Future<List<Chapter>> fetchChapters(Book book) {
    return _ChaptersFetcher(this, book).fetch();
  }

  @override
  Future<Pair<Book, List<Chapter>>> fetchBookAndChapters(Book book) {
    return _BookAndChaptersFetcher(this, book).fetch();
  }

  @override
  Future<List<Page>> fetchPages(Chapter chapter) {
    return _PagesFetcher(this, chapter).fetch();
  }
}

class _BooksFetcher extends Fetcher<List<Book>> {
  final int page;
  final String query;
  final List<Filter> filters;

  _BooksFetcher(OnlineSource source, this.page, this.query, this.filters)
      : super(source);

  @override
  List<Book> onFailure(Object error, StackTrace stackTrace) {
    return [];
  }

  @override
  List<Book> onSuccess(Response response) {
    Map json = response.data;
    Map obj = json['response'];
    List array = (obj['result'] ?? obj['mangas']);
    return array.map((obj) {
      final status = obj['mangaIsOver'] == 0
          ? BookStatus.ongoing
          : (obj['mangaIsOver'] == 1
              ? BookStatus.completed
              : BookStatus.unknown);
      return Book(
        SourceIdentity.values.indexOf(source.identity),
        '/v1/manga/getDetail?mangaId=${obj['mangaId']}',
        title: obj['mangaName'],
        author: obj['mangaAuthor'],
        bookStatusIndex: BookStatus.values.indexOf(status),
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

class _BookFetcher extends Fetcher<Book> {
  final Book book;

  _BookFetcher(OnlineSource source, this.book)
      : assert(book != null),
        super(source);

  @override
  Book onFailure(Object error, StackTrace stackTrace) {
    return null;
  }

  @override
  Book onSuccess(Response response) {
    Map obj = response.data['response'];
    String thumbnailUrl = obj['mangaCoverimageUrl'] ?? '';
    if (thumbnailUrl.isEmpty) {
      thumbnailUrl = obj['mangaPicimageUrl'] ?? '';
      if (thumbnailUrl.isEmpty) {
        thumbnailUrl = obj['shareIcon'] ?? '';
      }
    }
    BookStatus status;
    switch (obj['mangaIsOver'] as int) {
      case 1:
        status = BookStatus.completed;
        break;
      case 0:
        status = BookStatus.ongoing;
        break;
      default:
        status = BookStatus.unknown;
        break;
    }
    return book.clone(
      title: obj['mangaName'],
      thumbnailUrl: thumbnailUrl,
      author: obj['mangaAuthors'].join(', '),
      genre: obj['mangaTheme'].replaceAll(' ', ', '),
      bookStatusIndex: BookStatus.values.indexOf(status),
      description: obj['mangaIntro'],
    );
  }

  @override
  RequestOptions get requestOptions => RequestOptions(path: book.url);
}

class _ChaptersFetcher extends Fetcher<List<Chapter>> {
  final Book book;

  _ChaptersFetcher(OnlineSource source, this.book)
      : assert(book != null),
        super(source);

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
          book: book,
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
  RequestOptions get requestOptions => RequestOptions(path: book.url);
}

class _BookAndChaptersFetcher extends Fetcher<Pair<Book, List<Chapter>>> {
  final Book book;

  _BookAndChaptersFetcher(OnlineSource source, this.book)
      : assert(book != null),
        super(source);

  @override
  Pair<Book, List<Chapter>> onFailure(Object error, StackTrace stackTrace) {
    return null;
  }

  @override
  Pair<Book, List<Chapter>> onSuccess(Response response) {
    Map obj = response.data['response'];
    String thumbnailUrl = obj['mangaCoverimageUrl'] ?? '';
    if (thumbnailUrl.isEmpty) {
      thumbnailUrl = obj['mangaPicimageUrl'] ?? '';
      if (thumbnailUrl.isEmpty) {
        thumbnailUrl = obj['shareIcon'] ?? '';
      }
    }
    BookStatus status;
    switch (obj['mangaIsOver'] as int) {
      case 1:
        status = BookStatus.completed;
        break;
      case 0:
        status = BookStatus.ongoing;
        break;
      default:
        status = BookStatus.unknown;
        break;
    }
    final book = this.book.clone(
          title: obj['mangaName'],
          thumbnailUrl: thumbnailUrl,
          author: obj['mangaAuthors'].join(', '),
          genre: obj['mangaTheme'].replaceAll(' ', ', '),
          bookStatusIndex: BookStatus.values.indexOf(status),
          description: obj['mangaIntro'],
        );
    var chapterList = <Chapter>[];
    ['mangaEpisode', 'mangaWords', 'mangaRolls'].forEach((type) {
      List array = obj[type];
      if (array == null) {
        return;
      }
      array.forEach((item) {
        final prefix = '${type == 'mangaEpisode' ? '【番外】' : ''}';
        final title =
            item['sectionTitle'] == '' ? '' : '：${item['sectionTitle']}';
        final name = '$prefix${item['sectionName']}$title';
        chapterList.add(Chapter(
          book: book,
          name: name,
          updateAt: utils.string2DateTime(item['releaseTime'], 'yyyy-MM-dd'),
          chapterNumber: item['sectionSort'],
          url: '/v1/manga/getRead?mangaSectionId=${item["sectionId"]}',
        ));
      });
    });
    return Pair(book, chapterList);
  }

  @override
  RequestOptions get requestOptions => RequestOptions(
      path: book.url, headers: {'Referer': 'http://www.dmzj.com/'});
}

class _PagesFetcher extends Fetcher<List<Page>> {
  final Chapter chapter;

  _PagesFetcher(OnlineSource source, this.chapter)
      : assert(chapter != null),
        super(source);

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
              chapter: chapter,
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

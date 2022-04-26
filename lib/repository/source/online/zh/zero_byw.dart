import 'package:dio/dio.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as html;

class ZeroBYW extends HTTPSource {
  static final provider = Provider.autoDispose((ref) => ZeroBYW._(ref));
  static const _categoryOptions = [
    MapEntry("", "全部"),
    MapEntry("1", "卖肉"),
    MapEntry("15", "战斗"),
    MapEntry("32", "日常"),
    MapEntry("6", "后宫"),
    MapEntry("13", "搞笑"),
    MapEntry("28", "日常"),
    MapEntry("31", "爱情"),
    MapEntry("22", "冒险"),
    MapEntry("23", "奇幻"),
    MapEntry("26", "战斗"),
    MapEntry("29", "体育"),
    MapEntry("34", "机战"),
    MapEntry("35", "职业"),
    MapEntry("36", "汉化组跟上，不再更新"),
  ];
  static const _statusOptions = [
    MapEntry("", "全部"),
    MapEntry("0", "连载中"),
    MapEntry("1", "已完结"),
  ];
  static const _langOptions = [
    MapEntry("", "全部"),
    MapEntry("一半中文一半生肉", "一半中文一半生肉"),
    MapEntry("全生肉", "全生肉"),
    MapEntry("全中文", "全中文"),
  ];

  ZeroBYW._(Ref ref) : super(ref);

  String _shortTitleOf(String title) {
    return title.replaceFirstMapped(RegExp(r'【.*'), (match) => '');
  }

  @override
  String get name => 'zero搬运网';

  @override
  String get lang => 'zh';

  @override
  bool get supportsLatest => true;

  @override
  String get baseUrl => 'http://www.zerobywtxt.com';

  @override
  Map<String, String> get headers => {};

  @override
  String get version => '1e0473d8bd91be4711a11db2919446e22d7913d6';

  @override
  List<Filter> get filters => [
        const Filter.header('如果使用文本搜索, 过滤器将被忽略'),
        Filter.select('分类', _categoryOptions.map((e) => e.value).toList()),
        Filter.select('进度', _statusOptions.map((e) => e.value).toList()),
        Filter.select('性质', _langOptions.map((e) => e.value).toList()),
      ];

  @override
  MangasPage popularMangaParser(Response response) {
    throw UnimplementedError();
  }

  @override
  RequestOptions popularMangaRequest({required int page}) {
    throw UnimplementedError();
  }

  @override
  MangasPage latestUpdatesParser(Response response) {
    final document = html.parse(response.data);
    final elements = document.querySelectorAll('div.uk-card');
    final mangas = elements.map((e) {
      final title = e.querySelector('p.mt5 > a')?.text;
      final key = e.querySelector('p.mt5 > a')?.attributes['href'];
      final cover = e.querySelector('img')?.attributes['src'];
      if (title == null || key == null || cover == null) {
        return null;
      }
      return MangaInfo(key.removedBaseURL, _shortTitleOf(title), cover: cover.addBaseURL(baseUrl));
    });
    return MangasPage(0, mangas.whereType<MangaInfo>().toList(), document.querySelector('div.pg > a.nxt') != null);
  }

  @override
  RequestOptions latestUpdatesRequest({required int page}) {
    return RequestOptions(
      baseUrl: baseUrl,
      path: '/plugin.php',
      queryParameters: {
        'id': 'jameson_manhua',
        'a': 'ku',
        'c': 'index',
        'page': '$page',
      },
    );
  }

  @override
  MangasPage searchMangaParser(Response response) {
    final document = html.parse(response.data);
    final mangas = document.querySelectorAll('a.uk-card, div.uk-card').map((e) {
      final title = e.querySelector('p.mt5')?.text;
      final key = e.querySelector('a')?.attributes['href'];
      final cover = e.querySelector('img')?.attributes['src'];
      if (title == null || key == null || cover == null) {
        return null;
      }
      return MangaInfo(key.removedBaseURL, _shortTitleOf(title), cover: cover.addBaseURL(baseUrl));
    });
    return MangasPage(0, mangas.whereType<MangaInfo>().toList(), document.querySelector('div.pg > a.nxt') != null);
  }

  @override
  RequestOptions searchMangaRequest({required int page, required String query, required List<Filter> filters}) {
    if (query.isEmpty) {
      final queryParameters = <String, dynamic>{'id': 'jameson_manhua', 'a': 'ku', 'c': 'index', 'page': '$page'};
      for (final filter in filters) {
        filter.maybeWhen(
          select: (name, _, index) {
            switch (name) {
              case '分类':
                queryParameters['category_id'] = _categoryOptions[index].key;
                break;
              case '进度':
                queryParameters['jindu'] = _categoryOptions[index].key;
                break;
              case '性质':
                queryParameters['shuxing'] = _categoryOptions[index].key;
                break;
            }
          },
          orElse: () {},
        );
      }
      return RequestOptions(
        baseUrl: baseUrl,
        path: '/plugin.php',
        queryParameters: queryParameters,
      );
    } else {
      return RequestOptions(
        baseUrl: baseUrl,
        path: '/plugin.php',
        queryParameters: {
          'id': 'jameson_manhua',
          'a': 'search',
          'c': 'index',
          'keyword': query,
          'page': '$page',
        },
      );
    }
  }

  @override
  MangaInfo mangaDetailsParser(Response response) {
    // TODO: implement mangaDetailsParser
    throw UnimplementedError();
  }

  @override
  List<ChapterInfo> chapterListParser(Response response) {
    // TODO: implement chapterListParser
    throw UnimplementedError();
  }

  @override
  List<Page> pageListParser(Response response) {
    // TODO: implement pageListParser
    throw UnimplementedError();
  }

  @override
  PageImageUrl imageUrlParser(Response response) {
    // TODO: implement imageUrlParser
    throw UnimplementedError();
  }
}

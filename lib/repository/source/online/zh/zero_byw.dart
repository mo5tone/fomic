import 'package:dio/dio.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/model/whoops.dart';
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
  List<SourceFilter> get filters => [
        const SourceFilter.header('如果使用文本搜索, 过滤器将被忽略'),
        SourceFilter.select('分类', _categoryOptions.map((e) => e.value).toList()),
        SourceFilter.select('进度', _statusOptions.map((e) => e.value).toList()),
        SourceFilter.select('性质', _langOptions.map((e) => e.value).toList()),
      ];

  @override
  SourceMangasPage popularMangaParser(Response response) {
    throw UnimplementedError();
  }

  @override
  RequestOptions popularMangaRequest({required int page}) {
    throw UnimplementedError();
  }

  @override
  SourceMangasPage latestUpdatesParser(Response response) {
    final document = html.parse(response.data);
    final elements = document.querySelectorAll('div.uk-card');
    final mangas = elements.map((e) {
      final title = e.querySelector('p.mt5 > a')?.text;
      final key = e.querySelector('p.mt5 > a')?.attributes['href'];
      final cover = e.querySelector('img')?.attributes['src'];
      if (title == null || key == null || cover == null) {
        return null;
      }
      return SourceManga(key.removedBaseURL, _shortTitleOf(title), cover: cover.addBaseURL(baseUrl));
    });
    return SourceMangasPage(mangas.whereType<SourceManga>().toList(), document.querySelector('div.pg > a.nxt') != null);
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
  SourceMangasPage searchMangaParser(Response response) {
    final document = html.parse(response.data);
    final mangas = document.querySelectorAll('a.uk-card, div.uk-card').map((e) {
      final title = e.querySelector('p.mt5')?.text;
      final key = e.querySelector('a')?.attributes['href'];
      final cover = e.querySelector('img')?.attributes['src'];
      if (title == null || key == null || cover == null) {
        return null;
      }
      return SourceManga(key.removedBaseURL, _shortTitleOf(title), cover: cover.addBaseURL(baseUrl));
    });
    return SourceMangasPage(mangas.whereType<SourceManga>().toList(), document.querySelector('div.pg > a.nxt') != null);
  }

  @override
  RequestOptions searchMangaRequest({required int page, required String query, required List<SourceFilter> filters}) {
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
  SourceManga mangaDetailsParser(Response response) {
    final document = html.parse(response.data);
    final title = document.querySelector('li > h3.uk-heading-line')!.text;
    final cover = document.querySelector('div.uk-width-medium > img')!.attributes['src']!;
    final author = document.querySelector('div.cl > a.uk-label')!.text.substring(3);
    final artist = author;
    final genres = document.querySelectorAll('div.cl > a.uk-label, div.cl > span.uk-label').map((e) => e.text);
    final description = document.querySelector('li > div.uk-alert')!.innerHtml.replaceAll('<br>', '');
    final statusRawValue = document.querySelectorAll('div.cl > span.uk-label').last.text;
    SourceMangaStatus status;
    switch (statusRawValue) {
      case '连载中':
        status = SourceMangaStatus.ongoing;
        break;
      case '已完结':
        status = SourceMangaStatus.completed;
        break;
      default:
        status = SourceMangaStatus.unknown;
        break;
    }
    return SourceManga(
      '',
      _shortTitleOf(title),
      cover: cover.addBaseURL(baseUrl),
      author: author,
      artist: artist,
      genres: genres.toList(),
      description: description,
      status: status,
    );
  }

  @override
  List<SourceChapter> chapterListParser(Response response) {
    final document = html.parse(response.data);
    final chapterList = document
        .querySelectorAll('div.uk-grid-collapse > div.muludiv')
        .map((e) {
          final key = e.querySelector('a.uk-button-default')?.attributes['href'];
          final name = e.querySelector('a.uk-button-default')?.text;
          if (key == null || name == null) {
            return null;
          }
          return SourceChapter(key.removedBaseURL, name);
        })
        .whereType<SourceChapter>()
        .toList();
    return chapterList.reversed.toList();
  }

  @override
  List<SourcePage> pageListParser(Response response) {
    final document = html.parse(response.data);
    var imageElements = document.querySelectorAll('div.uk-text-center > img');
    if (imageElements.isEmpty) {
      var message = document.querySelector('div#messagetext > p');
      message ??= document.querySelector('div.uk-alert > p');
      if (message == null) {
        throw const Whoops.toast('Failed to parse pages');
      }
      return [SourcePage.text(message.text)];
    }
    return imageElements
        .map((e) {
          final src = e.attributes['src'];
          return src == null ? null : SourcePage.imageUrl(src);
        })
        .whereType<SourcePage>()
        .toList();
  }

  @override
  SourcePageImageUrl imageUrlParser(Response response) {
    throw UnimplementedError();
  }
}

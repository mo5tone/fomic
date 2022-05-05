import 'package:dio/dio.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/service/network/interceptor/rate_limit_interceptor.dart';
import 'package:fomic/repository/service/network/request.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as html;

class BaiManGu extends HTTPSource {
  static final provider = Provider.autoDispose((ref) => BaiManGu._(ref));

  static const channelFilterOptions = [
    MapEntry('最新漫画', '1'),
    MapEntry('漫画更新', '2'),
    MapEntry('更多漫画', '3'),
    MapEntry('漫画大全', '4'),
  ];

  static const sortFilterOptions = [
    MapEntry('时间', 'time'),
    MapEntry('人气', 'hits'),
    MapEntry('评分', 'score'),
  ];

  @override
  String get name => '百漫谷';

  @override
  String get lang => 'zh';

  @override
  String get version => '1';

  @override
  bool get supportsLatest => true;

  @override
  String get baseUrl => 'https://www.darpou.com';

  @override
  Map<String, String> get headers => {'Referer': baseUrl};

  @override
  Iterable<Interceptor> get interceptors => [
        RateLimitInterceptor(permits: 6, period: const Duration(seconds: 1), host: Uri.parse(baseUrl).host),
      ];

  @override
  List<SourceFilter> get filters => [
        SourceFilter.select('频道', channelFilterOptions.map((e) => e.key).toList()),
        SourceFilter.select('排序', sortFilterOptions.map((e) => e.key).toList()),
      ];

  BaiManGu._(Ref ref) : super(ref);

  @override
  SourceMangasPage latestUpdatesParser(Response response) {
    final document = html.parse(response.data);
    final hasNextPage = document.querySelectorAll('a.fed-btns-info.fed-rims-info').reversed.length > 3;
    final mangas = document
        .querySelectorAll('li.fed-list-item')
        .map((element) {
          final pics = element.querySelector('a.fed-list-pics');
          final key = pics?.attributes['href'];
          final title = element.querySelector('a.fed-list-title')?.text;
          final cover = pics?.attributes['data-original'];
          if (key == null || title == null || cover == null) {
            return null;
          }
          return SourceManga(key.removedBaseURL, title, cover: cover.addBaseURL(baseUrl));
        })
        .whereType<SourceManga>()
        .toList();
    return SourceMangasPage(mangas, hasNextPage);
  }

  @override
  Request latestUpdatesRequest({required int page}) {
    return Request('/fenlei/2-$page.html');
  }

  @override
  SourceMangasPage popularMangaParser(Response response) => latestUpdatesParser(response);

  @override
  Request popularMangaRequest({required int page}) {
    return Request('/vodshow/4--hits------$page---.html');
  }

  @override
  SourceMangasPage searchMangaParser(Response response) {
    final document = html.parse(response.data);
    final hasNextPage = document.querySelectorAll('a.fed-btns-info.fed-rims-info').reversed.length > 3;
    final mangas = document
        .querySelectorAll('dl.fed-deta-info, li.fed-list-item')
        .map((element) {
          if (element.outerHtml.startsWith('<li')) {
            final pics = element.querySelector('a.fed-list-pics');
            final key = pics?.attributes['href'];
            final title = element.querySelector('a.fed-list-title')?.text;
            final cover = pics?.attributes['data-original'];
            if (key == null || title == null || cover == null) {
              return null;
            }
            return SourceManga(key.removedBaseURL, title, cover: cover.addBaseURL(baseUrl));
          } else {
            final pics = element.querySelector('a.fed-list-pics');
            final key = pics?.attributes['href'];
            final title = element.querySelector('dd.fed-deta-content a:first-child')?.text;
            final cover = pics?.attributes['data-original'];
            if (key == null || title == null || cover == null) {
              return null;
            }
            return SourceManga(key.removedBaseURL, title, cover: cover.addBaseURL(baseUrl));
          }
        })
        .whereType<SourceManga>()
        .toList();
    return SourceMangasPage(mangas, hasNextPage);
  }

  @override
  Request searchMangaRequest({required int page, required String query, required List<SourceFilter> filters}) {
    if (query.isEmpty) {
      var channel = '4';
      var sort = 'time';
      for (var filter in filters) {
        filter.maybeWhen(
          select: (name, options, state) {
            switch (name) {
              case '频道':
                channel = channelFilterOptions[state].value;
                break;
              case '排序':
                sort = sortFilterOptions[state].value;
                break;
            }
          },
          orElse: () {},
        );
      }
      return Request('/vodshow/$channel--$sort------$page---');
    } else {
      return Request('/vodsearch/$query----------$page---');
    }
  }

  @override
  SourceManga mangaDetailsParser(Response response) {
    // TODO: implement mangaDetailsParser
    throw UnimplementedError();
  }

  @override
  List<SourceChapter> chapterListParser(Response response) {
    // TODO: implement chapterListParser
    throw UnimplementedError();
  }

  @override
  List<SourcePage> pageListParser(Response response) {
    // TODO: implement pageListParser
    throw UnimplementedError();
  }

  @override
  SourcePageImageUrl imageUrlParser(Response response) {
    // TODO: implement imageUrlParser
    throw UnimplementedError();
  }
}

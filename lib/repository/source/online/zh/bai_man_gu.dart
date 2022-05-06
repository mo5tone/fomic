import 'dart:async';

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
    MapEntry('漫画大全', '4'),
    MapEntry('最新漫画', '1'),
    MapEntry('漫画更新', '2'),
    MapEntry('更多漫画', '3'),
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
          return SourceManga(key.removedBaseUrl, title, cover: cover.addBaseUrl(baseUrl));
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
          if (element.localName == 'li') {
            final pics = element.querySelector('a.fed-list-pics');
            final key = pics?.attributes['href'];
            final title = element.querySelector('a.fed-list-title')?.text;
            final cover = pics?.attributes['data-original'];
            if (key == null || title == null || cover == null) {
              return null;
            }
            return SourceManga(key.removedBaseUrl, title, cover: cover.addBaseUrl(baseUrl));
          } else {
            final pics = element.querySelector('a.fed-list-pics');
            final key = pics?.attributes['href'];
            final title = element.querySelector('dd.fed-deta-content a:first-child')?.text;
            final cover = pics?.attributes['data-original'];
            if (key == null || title == null || cover == null) {
              return null;
            }
            return SourceManga(key.removedBaseUrl, title, cover: cover.addBaseUrl(baseUrl));
          }
        })
        .whereType<SourceManga>()
        .toList();
    return SourceMangasPage(mangas, hasNextPage);
  }

  @override
  Request searchMangaRequest({required int page, required String query, required List<SourceFilter> filters}) {
    if (query.isEmpty) {
      var channel = channelFilterOptions.first.value;
      var sort = sortFilterOptions.first.value;
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
    final document = html.parse(response.data);
    final title = document.querySelector('h1.fed-part-eone')?.text.trim();
    final detailsElment = document.querySelector('.fed-deta-content ul.fed-part-rows');
    final author = detailsElment?.querySelector('li:nth-child(1)')?.querySelectorAll('a').map((e) => e.text).join(', ');
    final description = detailsElment?.querySelectorAll('li.fed-show-md-block').last.text.replaceAllMapped(RegExp(r'简介：?'), (match) => '').trim();
    final genres =
        detailsElment?.querySelectorAll('li.fed-show-md-block').first.querySelectorAll('a').map((e) => e.text.trim()).where((e) => e.isNotEmpty).toList();
    final cover = document.querySelector('a.fed-list-pics')?.attributes['data-original'];
    return response.manga?.copyWith(title: title!, author: author!, description: description!, genres: genres!, cover: cover!) ??
        SourceManga('', title!, author: author!, description: description!, genres: genres!, cover: cover!);
  }

  @override
  List<SourceChapter> chapterListParser(Response response) {
    final document = html.parse(response.data);
    return document
        .querySelectorAll('div.fed-play-item ul.fed-part-rows:last-child a')
        .map((element) {
          final key = element.attributes['href'];
          final name = element.text.trim();
          if (key == null) return null;
          return SourceChapter(key, name);
        })
        .whereType<SourceChapter>()
        .toList();
  }

  @override
  FutureOr<List<SourcePage>> pageListParser(Response response) {
    final script = RegExp(r'<script>(((?!<script>)[\s\S])*oScript.src((?!<\/script>)[\s\S])*)<\/script>').firstMatch(response.data)?.group(1);
    if (script == null) return [];
    final url = RegExp(r'src(\s*)=(\s*)"(.+)";').firstMatch(script)?.group(3);
    if (url == null) return [];
    return fetch(Request(url), parser: (resp) {
      final String content = resp.data;
      if (content.contains('show(') && content.contains('<img')) {
        return RegExp(r'src="([^>]+)"')
            .allMatches(content)
            .map((m) {
              final imageUrl = m.group(1);
              if (imageUrl == null) return null;
              return SourcePage.imageUrl(imageUrl);
            })
            .whereType<SourcePage>()
            .toList();
      }
      return [];
    });
  }

  @override
  SourcePageImageUrl imageUrlParser(Response response) {
    throw UnimplementedError();
  }
}

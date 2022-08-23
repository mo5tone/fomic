import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fomic/common/util/javascript_io.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/service/network/request.dart';
import 'package:fomic/repository/source/online/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as html;

class WuQiManHua extends HTTPSource {
  static final provider = Provider.autoDispose((ref) => WuQiManHua._(ref.read));
  static const _imageBaseURL = 'http://images.lancaier.com';

  @override
  String get name => '57漫画';

  @override
  String get lang => 'zh';

  @override
  String get commit => 'f94099b8e80f18671956948827df52b9c3715a7f';

  @override
  bool get supportsLatest => false;

  @override
  String get baseUrl => 'http://www.wuqimh.net';

  @override
  get headers => {'Referer': '$baseUrl/'};

  WuQiManHua._(Reader read) : super(read);

  @override
  SourceMangasPage latestUpdatesParser(Response response) {
    throw UnimplementedError();
  }

  @override
  Request latestUpdatesRequest({required int page}) {
    throw UnimplementedError();
  }

  @override
  SourceMangasPage popularMangaParser(Response response) {
    final document = html.parse(response.data);
    final mangas = document
        .querySelectorAll('ul#contList > li')
        .map((e) {
          final coverElement = e.querySelector('a img');
          final cover = coverElement?.attributes['data-src'] ?? coverElement?.attributes['src'];
          final title = e.querySelector('a')?.attributes['title'];
          final key = e.querySelector('a')?.attributes['href'];
          if (key == null || title == null || cover == null) {
            return null;
          }
          return SourceManga(key.removedBaseUrl, title, cover: cover.addBaseUrl(baseUrl));
        })
        .whereType<SourceManga>()
        .toList();
    return SourceMangasPage(mangas, false);
  }

  @override
  Request popularMangaRequest({required int page}) {
    return Request('/list/area-日本-order-hits');
  }

  @override
  SourceMangasPage searchMangaParser(Response response) {
    final document = html.parse(response.data);
    final mangas = document.querySelectorAll('div.book-result li.cf').map((e) {
      final detailElement = e.querySelector('div.book-detail');
      final titleElement = detailElement?.querySelector('dl > dt > a');
      final key = titleElement?.attributes['href'];
      final title = titleElement?.attributes['title'];
      final description = detailElement?.querySelector('dd.intro')?.text;
      SourceMangaStatus status;
      if (detailElement?.querySelector('dd.tags.status')?.querySelector('span.red')?.text == '连载中') {
        status = SourceMangaStatus.ongoing;
      } else {
        status = SourceMangaStatus.completed;
      }
      final author =
          detailElement?.querySelectorAll('dd.tags').firstWhere((element) => element.querySelector('span strong')?.text == '作者').querySelector('span a')?.text;
      final cover = e.querySelector('a.bcover > img')?.attributes['src'];
      if (key == null || title == null || cover == null) {
        return null;
      }
      return SourceManga(key, title, cover: cover, description: description ?? '', author: author ?? '', status: status);
    }).whereType<SourceManga>();
    return SourceMangasPage(mangas.toList(), document.querySelector('div.book-result > div > span > a.prev') != null);
  }

  @override
  Request searchMangaRequest({required int page, required String query, required List<SourceFilter> filters}) {
    return Request('/search/q_$query-p-$page');
  }

  @override
  SourceManga mangaDetailsParser(Response response) {
    var manga = response.requestOptions.extra['manga'] as SourceManga;
    final document = html.parse(response.data);
    final title = document.querySelector('.book-title h1')?.text;
    final cover = document.querySelector('.hcover img')?.attributes['src'];
    String? author;
    for (final e in document.querySelectorAll('ul.detail-list li span')) {
      if (e.querySelector('strong')?.text.contains('漫画作者') ?? false) {
        author = e.querySelector('a')?.text;
      }
    }
    if (title != null) {
      manga = manga.copyWith(title: title);
    }
    if (cover != null) {
      manga = manga.copyWith(cover: cover);
    }
    if (author != null) {
      manga = manga.copyWith(author: author);
    }
    return manga;
  }

  @override
  List<SourceChapter> chapterListParser(Response response) {
    final document = html.parse(response.data);
    final elements = document.querySelectorAll('div.chapter div.chapter-list>ul').reversed;
    return elements
        .map((element) => element.querySelectorAll('li a').map((e) => SourceChapter(e.attributes['href']!, e.attributes['title']!)))
        .expand((e) => e)
        .toList();
  }

  @override
  List<SourcePage> pageListParser(Response response) {
    final document = html.parse(response.data);
    final code = RegExp(r'eval(.*?)\n').firstMatch(document.outerHtml)?.group(1);
    if (code == null) return [];
    String result = eval(code);
    final imageJSONString = RegExp(r'\{.*\}').firstMatch(result)?.group(0)?.replaceAll("'", '"');
    if (imageJSONString == null) return [];
    List urls = json.decode(imageJSONString)['fs'];
    return urls.whereType<String>().map((url) => SourcePage.imageUrl('$_imageBaseURL${url.removedBaseUrl}')).toList();
  }

  @override
  SourcePageImageUrl imageUrlParser(Response response) {
    throw UnimplementedError();
  }
}

import 'package:dio/dio.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/model/source_mangas_page.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/service/network/request.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as html;

class WuQiManHua extends HTTPSource {
  @override
  String get name => '57漫画';

  @override
  String get lang => 'zh';

  @override
  String get version => '2';

  @override
  bool get supportsLatest => false;

  @override
  String get baseUrl => 'http://www.wuqimh.com';

  @override
  get headers => {'Referer': '$baseUrl/'};

  WuQiManHua._(Ref ref) : super(ref);

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
          return SourceManga(key.removedBaseURL, title, cover: cover.addBaseURL(baseUrl));
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
    final document = html.parse(response.data);
    final title = document.querySelector('.book-title h1')!.text;
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

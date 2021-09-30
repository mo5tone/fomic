import 'dart:convert';

import 'package:fomic/repository/service/requisition.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:dio/dio.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:html/parser.dart' as html;
import 'package:intl/intl.dart';

class Kuaikanmanhua extends HttpSource {
  static final provider = Provider.autoDispose((ref) => Kuaikanmanhua._(ref));

  static const _lockIcon = '\uD83D\uDD12';
  static const _topicIdSearchPrefix = 'topic:';
  static const _apiBaseUrl = 'https://api.kkmh.com';

  Kuaikanmanhua._(ProviderRefBase ref) : super(ref);

  @override
  int get id => 1;

  @override
  String get name => 'Kuaikanmanhua';

  @override
  String get baseUrl => 'https://www.kuaikanmanhua.com';

  @override
  Map<String, String> get headers => {};

  @override
  bool get supportsLatest => true;

  @override
  List<Filter> get filters {
    return [
      const FilterSelect('类别', [
        MapEntry('全部', '1'),
        MapEntry('连载中', '2'),
        MapEntry('已完结', '3'),
      ]),
      const FilterSelect('题材', [
        MapEntry('全部', '0'),
        MapEntry('恋爱', '20'),
        MapEntry('古风', '46'),
        MapEntry('校园', '47'),
        MapEntry('奇幻', '22'),
        MapEntry('大女主', '77'),
        MapEntry('治愈', '27'),
        MapEntry('总裁', '52'),
        MapEntry('完结', '40'),
        MapEntry('唯美', '58'),
        MapEntry('日漫', '57'),
        MapEntry('韩漫', '60'),
        MapEntry('穿越', '80'),
        MapEntry('正能量', '54'),
        MapEntry('灵异', '32'),
        MapEntry('爆笑', '24'),
        MapEntry('都市', '48'),
        MapEntry('萌系', '62'),
        MapEntry('玄幻', '63'),
        MapEntry('日常', '19'),
        MapEntry('投稿', '76'),
      ]),
    ];
  }

  @override
  Requisition popularMangaRequest({required int page}) {
    return Requisition(path: '$_apiBaseUrl/v1/topic_new/lists/get_by_tag?tag=0&since=${(page - 1) * 10}');
  }

  @override
  MangasPage popularMangaParser(Response response) {
    List arr = response.data['data']['topics'];
    final mangas = <MangaInfo>[];
    for (final obj in arr) {
      mangas.add(MangaInfo("/web/topic/${obj['id']}", obj['title'], cover: obj['vertical_image_url']));
    }
    return MangasPage(0, mangas, mangas.length > 9);
  }

  @override
  Requisition latestUpdatesRequest({required int page}) {
    return Requisition(path: '$_apiBaseUrl/v1/topic_new/lists/get_by_tag?tag=19&since=${(page - 1) * 10}');
  }

  @override
  MangasPage latestUpdatesParser(Response response) {
    return popularMangaParser(response);
  }

  @override
  Requisition searchMangaRequest({required int page, required String query, required List<Filter> filters}) {
    if (query.isNotEmpty) {
      return Requisition(path: '$_apiBaseUrl/v1/search/topic?q=$query&size=18');
    } else {
      var genre = '';
      var status = '';
      for (final filter in filters) {
        if (filter is FilterSelect) {
          final index = filter.value;
          if (filter.name == '类别') {
            status = filter.options[index].value;
          } else if (filter.name == '题材') {
            genre = filter.options[index].value;
          }
        }
      }
      return Requisition(path: '$_apiBaseUrl/v1/search/by_tag?since=${(page - 1) * 10}&tag=$genre&sort=1&query_category=%7B%22update_status%22:$status%7D');
    }
  }

  @override
  MangasPage searchMangaParser(Response response) {
    final obj = response.data['data'];
    List arr = obj['hit'] ?? obj['topics'];
    final mangas = <MangaInfo>[];
    for (final obj in arr) {
      mangas.add(MangaInfo("/web/topic/${obj['id']}", obj['title'], cover: obj['vertical_image_url']));
    }
    return MangasPage(0, mangas, mangas.length > 9);
  }

  @override
  Future<MangasPage> fetchSearchManga({required int page, required String query, required List<Filter> filters}) {
    if (query.startsWith(_topicIdSearchPrefix)) {
      final newQuery = query.substring(_topicIdSearchPrefix.length);
      return networker.fetch<MangasPage>(Requisition(path: '$_apiBaseUrl/v1/topics/$newQuery'), parser: (response) {
        final manga = mangaDetailsParser(response).copyWith(key: '/web/topic/$newQuery');
        return MangasPage(0, [manga], false);
      });
    }
    return super.fetchSearchManga(page: page, query: query, filters: filters);
  }

  @override
  MangaInfo mangaDetailsParser(Response response) {
    Map data = response.data['data'];
    return MangaInfo(
      '',
      data['title'],
      cover: data['vertical_image_url'],
      author: data['user']['nickname'],
      description: data['description'],
      status: MangaInfoStatus.values[data['update_status_code']],
    );
  }

  @override
  Future<MangaInfo> fetchMangaDetails({required MangaInfo manga}) {
    final path = '$_apiBaseUrl/v1/topics/${manga.key.split('/').last}';
    return networker.fetch(Requisition(path: path), parser: mangaDetailsParser);
  }

  @override
  List<ChapterInfo> chapterListParser(Response response) {
    final chapters = <ChapterInfo>[];
    final document = html.parse(response.data);
    String script = document.getElementsByTagName('script').firstWhere((ele) => ele.innerHtml.contains('comics:')).innerHtml;
    List comics = json.decode(RegExp(r'comics:(.*}\]),first_comic_id').firstMatch(script)?.group(1)?.withQuotes ?? '[]');
    final variables = RegExp(r'\(function\((.*)\){').firstMatch(script)?.group(1)?.split(',') ?? [];
    final values = RegExp(r'}}\((.*)\)\);').firstMatch(script)?.group(1)?.split(',') ?? [];
    final elements = document.querySelectorAll('div.TopicItem');
    for (var i = 0; i < elements.length; i++) {
      final e = elements[i];
      final id = values[variables.indexOf(comics[i]['id'])];
      var name = e.querySelector('div.title > a')?.text.trim() ?? '';
      if (e.querySelectorAll('i.lockedIcon').isNotEmpty) {
        name += ' $_lockIcon';
      }
      var dateUploadString = e.querySelector('div.date > span')?.text ?? '';
      if (dateUploadString.length == 5) {
        dateUploadString = '${DateTime.now().year}-$dateUploadString';
      } else {
        dateUploadString = '20$dateUploadString';
      }
      final dateUpload = DateFormat('yyyy-MM-dd').parse(dateUploadString).millisecondsSinceEpoch;
      final chapter = ChapterInfo('/web/comic/$id', name, dateUpload: dateUpload);
      chapters.add(chapter);
    }
    return chapters;
  }

  @override
  Requisition pageListRequest({required ChapterInfo chapter}) {
    if (chapter.name.endsWith(_lockIcon)) {
      throw '此章节为付费内容';
    }
    return super.pageListRequest(chapter: chapter);
  }

  @override
  List<Page> pageListParser(Response response) {
    final pages = <Page>[];
    final document = html.parse(response.data);
    String script = document.getElementsByTagName('script').firstWhere((ele) => ele.innerHtml.contains('comicImages:')).innerHtml;
    List images = jsonDecode(script.allMatches(r'comicImages:(.*)},nextComicInfo').first.group(1) ?? '[]');
    final variables = script.allMatches(r'function\((.*)\){').first.group(1)?.split(',') ?? [];
    final values = script.allMatches(r'function\((.*)\){').first.group(1)?.split(',') ?? [];
    for (int i = 0; i < images.length; i++) {
      final url = values[variables.indexOf(images[i]['url'])].replaceAll('\\u002F', '/').replaceAll('"', '');
      pages.add(Page.imageUrl(url));
    }
    return pages;
  }

  @override
  PageImageUrl imageUrlParser(Response response) {
    throw UnimplementedError();
  }
}

extension on String {
  String get withQuotes {
    return replaceAllMapped(RegExp(r'[^\[\]{}:,]+'), (match) => '"${match.group(0)}"');
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/service/request.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as html;

class KuaiKanManHua extends HTTPSource {
  static final provider = Provider.autoDispose((ref) => KuaiKanManHua._(ref));

  static const _lockIcon = '\uD83D\uDD12';
  static const _topicIdSearchPrefix = 'topic:';
  static const _apiBaseUrl = 'https://api.kkmh.com';
  static const _statusOptions = [
    MapEntry('全部', '1'),
    MapEntry('连载中', '2'),
    MapEntry('已完结', '3'),
  ];
  static const _genreOptions = [
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
  ];

  KuaiKanManHua._(Ref ref) : super(ref);

  @override
  String get name => '快看漫画';

  @override
  String get lang => 'zh';

  @override
  int get version => 0;

  @override
  String get baseUrl => 'https://www.kuaikanmanhua.com';

  @override
  Map<String, String> get headers => {};

  @override
  List<Filter> get filters => [
        Filter.select('类别', _statusOptions.map((e) => e.key).toList()),
        Filter.select('题材', _genreOptions.map((e) => e.key).toList()),
      ];

  @override
  bool get supportsLatest => true;

  @override
  Request popularMangaRequest({required int page}) {
    return Request(path: '$_apiBaseUrl/v1/topic_new/lists/get_by_tag?tag=0&since=${(page - 1) * 10}');
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
  Request latestUpdatesRequest({required int page}) {
    return Request(path: '$_apiBaseUrl/v1/topic_new/lists/get_by_tag?tag=19&since=${(page - 1) * 10}');
  }

  @override
  MangasPage latestUpdatesParser(Response response) {
    return popularMangaParser(response);
  }

  @override
  Request searchMangaRequest({required int page, required String query, required List<Filter> filters}) {
    if (query.isNotEmpty) {
      return Request(path: '$_apiBaseUrl/v1/search/topic?q=$query&size=18');
    } else {
      var status = '';
      var genre = '';
      for (final filter in filters) {
        filter.maybeWhen(
          select: (name, _, index) {
            if (name == '类别') {
              status = _statusOptions[index].value;
            } else if (name == '题材') {
              genre = _genreOptions[index].value;
            }
          },
          orElse: () {},
        );
      }
      return Request(path: '$_apiBaseUrl/v1/search/by_tag?since=${(page - 1) * 10}&tag=$genre&sort=1&query_category=%7B%22update_status%22:$status%7D');
    }
  }

  @override
  MangasPage searchMangaParser(Response response) {
    final obj = response.data['data'];
    List arr = obj['hit'] ?? obj['topics'];
    final mangas = arr.map((e) => MangaInfo("/web/topic/${e['id']}", e['title'], cover: e['vertical_image_url'])).toList(growable: false);
    return MangasPage(0, mangas, mangas.length > 9 && obj['hit'] == null);
  }

  @override
  Future<MangasPage> searchManga({required int page, required String query, required List<Filter> filters}) {
    if (query.startsWith(_topicIdSearchPrefix)) {
      final newQuery = query.substring(_topicIdSearchPrefix.length);
      return networker.fetch<MangasPage>(Request(path: '$_apiBaseUrl/v1/topics/$newQuery'), parser: (response) {
        final manga = mangaDetailsParser(response).copyWith(key: '/web/topic/$newQuery');
        return MangasPage(0, [manga], false);
      });
    }
    return super.searchManga(page: page, query: query, filters: filters);
  }

  @override
  Request mangaDetailsRequest({required MangaInfo manga}) {
    return Request(path: '$_apiBaseUrl/v1/topics/${manga.key.split('/').last}');
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
  Request chapterListRequest({required MangaInfo manga}) {
    return Request(path: '$_apiBaseUrl/v1/topics/${manga.key.split('/').last}');
  }

  @override
  List<ChapterInfo> chapterListParser(Response response) {
    final chapters = <ChapterInfo>[];
    Map data = response.data['data'];
    List chapterJSONArray = data['comics'];
    for (final obj in chapterJSONArray) {
      final key = '/web/comic/${obj['id']}';
      final name = obj['title'] + (obj['can_view'] ? '' : _lockIcon);
      final dateUpload = obj['created_at'] * 1000;
      chapters.add(ChapterInfo(key, name, dateUpload: dateUpload));
    }
    return chapters;
  }

  @override
  List<Page> pageListParser(Response response) {
    final document = html.parse(response.data);
    String script = document.getElementsByTagName('script').firstWhere((ele) => ele.innerHtml.contains('comicImages:')).innerHtml;
    var imagesStringRawValue = RegExp(r'comicImages:(.*)},nextComicInfo').firstMatch(script)?.group(1) ?? '[]';
    imagesStringRawValue = imagesStringRawValue.replaceAllMapped(RegExp(r'(:([^\[\{\"]+?)[\},])'), (match) {
      final value = match.group(1) ?? '';
      if (value.isEmpty) {
        return value;
      }
      return value[0] + '"' + value.substring(1, value.length - 1) + '"' + value[value.length - 1];
    });
    imagesStringRawValue = imagesStringRawValue.replaceAllMapped(RegExp(r'([,{]([^\[\{\"]+?)[\}:])'), (match) {
      final value = match.group(1) ?? '';
      if (value.isEmpty) {
        return value;
      }
      return value[0] + '"' + value.substring(1, value.length - 1) + '"' + value[value.length - 1];
    });
    List images = jsonDecode(imagesStringRawValue);
    final variable = RegExp(r'\(function\((.*)\){').firstMatch(script)?.group(1)?.split(',') ?? [];
    final values = RegExp(r'}}\((.*)\)\);').firstMatch(script)?.group(1)?.split(',') ?? [];
    return images.map((image) => Page.imageUrl(values[variable.indexOf(image['url'])].replaceAll('\\u002F', '/').replaceAll('"', ''))).toList(growable: false);
  }

  @override
  PageImageUrl imageUrlParser(Response response) {
    throw UnimplementedError();
  }
}

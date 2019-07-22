import 'dart:math' as math;

import 'package:fomic/model/filter.dart';
import 'package:fomic/model/pair.dart';

class GenreFilter extends Filter<int, String> {
  GenreFilter(int key) : super(key);

  @override
  String get name => '分类';

  @override
  List<Pair<String, String>> get options => [
        Pair('全部', ''),
        Pair('冒险', '4'),
        Pair('百合', '3243'),
        Pair('生活', '3242'),
        Pair('四格', '17'),
        Pair('伪娘', '3244'),
        Pair('悬疑', '3245'),
        Pair('后宫', '3249'),
        Pair('热血', '3248'),
        Pair('耽美', '3246'),
        Pair('其他', '16'),
        Pair('恐怖', '14'),
        Pair('科幻', '7'),
        Pair('格斗', '6'),
        Pair('欢乐向', '5'),
        Pair('爱情', '8'),
        Pair('侦探', '9'),
        Pair('校园', '13'),
        Pair('神鬼', '12'),
        Pair('魔法', '11'),
        Pair('竞技', '10'),
        Pair('历史', '3250'),
        Pair('战争', '3251'),
        Pair('魔幻', '5806'),
        Pair('扶她', '5345'),
        Pair('东方', '5077'),
        Pair('奇幻', '5848'),
        Pair('轻小说', '6316'),
        Pair('仙侠', '7900'),
        Pair('搞笑', '7568'),
        Pair('颜艺', '6437'),
        Pair('性转换', '4518'),
        Pair('高清单行', '4459'),
        Pair('治愈', '3254'),
        Pair('宅系', '3253'),
        Pair('萌系', '3252'),
        Pair('励志', '3255'),
        Pair('节操', '6219'),
        Pair('职场', '3328'),
        Pair('西方魔幻', '3365'),
        Pair('音乐舞蹈', '3326'),
        Pair('机战', '3325'),
      ];

  @override
  String get value {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].second;
  }

  @override
  String get description {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].first;
  }
}

class StatusFilter extends Filter<int, String> {
  StatusFilter(int key) : super(key);

  @override
  String get name => '连载状态';

  @override
  List<Pair<String, String>> get options => [
        Pair('全部', ''),
        Pair('连载', '2309'),
        Pair('完结', '2310'),
      ];

  @override
  String get value {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].second;
  }

  @override
  String get description {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].first;
  }
}

class TypeFilter extends Filter<int, String> {
  TypeFilter(int key) : super(key);

  @override
  String get name => '地区';

  @override
  List<Pair<String, String>> get options => [
        Pair('全部', ''),
        Pair('日本', '2304'),
        Pair('韩国', '2305'),
        Pair('欧美', '2306'),
        Pair('港台', '2307'),
        Pair('内地', '2308'),
        Pair('其他', '8453'),
      ];

  @override
  String get value {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].second;
  }

  @override
  String get description {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].first;
  }
}

class SortFilter extends Filter<int, String> {
  SortFilter(int key) : super(key);

  @override
  String get name => '排序';

  @override
  List<Pair<String, String>> get options => [
        Pair('人气', '0'),
        Pair('更新', '1'),
      ];

  @override
  String get value {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].second;
  }

  @override
  String get description {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].first;
  }
}

class ReaderFilter extends Filter<int, String> {
  ReaderFilter(int key) : super(key);

  @override
  String get name => '读者';

  @override
  List<Pair<String, String>> get options => [
        Pair('全部', ''),
        Pair('少年', '3262'),
        Pair('少女', '3263'),
        Pair('青年', '3264'),
      ];

  @override
  String get value {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].second;
  }

  @override
  String get description {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    return options[key].first;
  }
}

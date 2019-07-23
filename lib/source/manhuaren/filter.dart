import 'dart:math' as math;

import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/common/helper/triplet.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends Filter<int, String> {
  SortFilter(int key) : super(key);

  @override
  String get name => '状态';

  @override
  List<Pair<String, String>> get options => [
        Pair('热门', '0'),
        Pair('更新', '1'),
        Pair('新作', '2'),
        Pair('完结', '3'),
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

class CategoryFilter extends Filter<int, Pair<String, String>> {
  CategoryFilter(int key) : super(key);

  @override
  String get name => '分类';

  List<Triplet<String, String, String>> get options => [
        Triplet('全部', '0', '0'),
        Triplet('热血', '0', '31'),
        Triplet('恋爱', '0', '26'),
        Triplet('校园', '0', '1'),
        Triplet('百合', '0', '3'),
        Triplet('耽美', '0', '27'),
        Triplet('伪娘', '0', '5'),
        Triplet('冒险', '0', '2'),
        Triplet('职场', '0', '6'),
        Triplet('后宫', '0', '8'),
        Triplet('治愈', '0', '9'),
        Triplet('科幻', '0', '25'),
        Triplet('励志', '0', '10'),
        Triplet('生活', '0', '11'),
        Triplet('战争', '0', '12'),
        Triplet('悬疑', '0', '17'),
        Triplet('推理', '0', '33'),
        Triplet('搞笑', '0', '37'),
        Triplet('奇幻', '0', '14'),
        Triplet('魔法', '0', '15'),
        Triplet('恐怖', '0', '29'),
        Triplet('神鬼', '0', '20'),
        Triplet('萌系', '0', '21'),
        Triplet('历史', '0', '4'),
        Triplet('美食', '0', '7'),
        Triplet('同人', '0', '30'),
        Triplet('运动', '0', '34'),
        Triplet('绅士', '0', '36'),
        Triplet('机甲', '0', '40'),
        Triplet('限制级', '0', '61'),
        Triplet('少年向', '1', '1'),
        Triplet('少女向', '1', '2'),
        Triplet('青年向', '1', '3'),
        Triplet('港台', '2', '35'),
        Triplet('日韩', '2', '36'),
        Triplet('大陆', '2', '37'),
        Triplet('欧美', '2', '52'),
      ];

  @override
  Pair<String, String> get value {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    var option = options[key];
    return Pair(option.second, option.third);
  }

  @override
  String get description {
    var key = this.key;
    key = math.min(math.max(key ??= 0, 0), options.length - 1);
    var option = options[key];
    return option.first;
  }
}

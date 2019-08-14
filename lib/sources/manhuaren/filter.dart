import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/filter.dart';

class SortFilter extends SelectableFilter<String> {
  SortFilter()
      : super('状态', [
          Pair('热门', '0'),
          Pair('更新', '1'),
          Pair('新作', '2'),
          Pair('完结', '3'),
        ]);

  @override
  String get alias => option.$0;

  @override
  String get value => option.$1;

  @override
  List<String> get aliases =>
      options.map((pair) => pair.$0).toList(growable: false);
}

class CategoryFilter extends SelectableFilter<Pair<String, String>> {
  CategoryFilter()
      : super('分类', [
          Pair('全部', Pair('0', '0')),
          Pair('热血', Pair('0', '31')),
          Pair('恋爱', Pair('0', '26')),
          Pair('校园', Pair('0', '1')),
          Pair('百合', Pair('0', '3')),
          Pair('耽美', Pair('0', '27')),
          Pair('伪娘', Pair('0', '5')),
          Pair('冒险', Pair('0', '2')),
          Pair('职场', Pair('0', '6')),
          Pair('后宫', Pair('0', '8')),
          Pair('治愈', Pair('0', '9')),
          Pair('科幻', Pair('0', '25')),
          Pair('励志', Pair('0', '10')),
          Pair('生活', Pair('0', '11')),
          Pair('战争', Pair('0', '12')),
          Pair('悬疑', Pair('0', '17')),
          Pair('推理', Pair('0', '33')),
          Pair('搞笑', Pair('0', '37')),
          Pair('奇幻', Pair('0', '14')),
          Pair('魔法', Pair('0', '15')),
          Pair('恐怖', Pair('0', '29')),
          Pair('神鬼', Pair('0', '20')),
          Pair('萌系', Pair('0', '21')),
          Pair('历史', Pair('0', '4')),
          Pair('美食', Pair('0', '7')),
          Pair('同人', Pair('0', '30')),
          Pair('运动', Pair('0', '34')),
          Pair('绅士', Pair('0', '36')),
          Pair('机甲', Pair('0', '40')),
          Pair('限制级', Pair('0', '61')),
          Pair('少年向', Pair('1', '1')),
          Pair('少女向', Pair('1', '2')),
          Pair('青年向', Pair('1', '3')),
          Pair('港台', Pair('2', '35')),
          Pair('日韩', Pair('2', '36')),
          Pair('大陆', Pair('2', '37')),
          Pair('欧美', Pair('2', '52')),
        ]);

  @override
  get alias => option.$0;

  @override
  Pair<String, Pair<String, String>> get value => option;

  String get type => value.$1.$0;

  String get id => value.$1.$1;

  @override
  List<String> get aliases =>
      options.map((pair) => pair.$0).toList(growable: false);
}

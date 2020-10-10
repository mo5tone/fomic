import 'package:flutter/material.dart';
import 'package:fomic/scene/explore/view/explore_view.dart';
import 'package:fomic/scene/explore/view_model/explore_view_model.dart';
import 'package:fomic/scene/setting/view/setting_view.dart';
import 'package:fomic/scene/setting/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'package:fomic/scene/common/view_model/tab_navigation_view_model.dart';
import 'package:fomic/scene/view.dart';

class TabNavigationView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<TabNavigationViewModel, TabNavigationView> with SingleTickerProviderStateMixin {
  final _pageController = PageController(initialPage: 0);

  void _onPageChanged(int index) {}

  Widget _itemBuilder(BuildContext context, int index) {
    Widget child;
    switch (index) {
      case 0:
        child = ChangeNotifierProvider(
          create: (_) => ExploreViewModel(),
          child: ExploreView(),
        );
        break;
      case 1:
        child = ChangeNotifierProvider(
          create: (_) => SettingViewModel(),
          child: SettingView(),
        );
        break;
      default:
        break;
    }
    return child;
  }

  void _onTap(int index) {
    if (index != _pageController.page) {
      vm.currentIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
    } else {
      vm.reTappedIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select((TabNavigationViewModel value) => value.currentIndex);
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        itemBuilder: _itemBuilder,
        itemCount: 2,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        onTap: _onTap,
        currentIndex: currentIndex,
      ),
    );
  }
}

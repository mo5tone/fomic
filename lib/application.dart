import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/bloc/hud_bloc.dart';
import 'package:fomic/common/bloc/theme_bloc.dart';
import 'package:fomic/feature/setting/view.dart';
import 'package:fomic/feature/source/mangas/view.dart';

class Fomic extends HookConsumerWidget {
  const Fomic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
    final themeState = ref.watch(ThemeBLoC.provider);
    ref.listen<HUDState>(HUDBLoC.provider, (value) {
      value.when(toast: (message, duration) {
        EasyLoading.showToast(message, duration: duration);
      }, loading: () {
        EasyLoading.show();
      }, done: () {
        EasyLoading.dismiss();
      });
    });
    return MaterialApp(
      title: 'Fomic',
      theme: themeState.theme,
      darkTheme: themeState.darkTheme,
      home: _Home(),
      builder: (context, child) {
        return FlutterEasyLoading(
          child: child,
        );
      },
    );
  }
}

class _Home extends HookConsumerWidget {
  final _currentIndex = StateProvider((_) => 0);
  final _bottomNavigationBarItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];

  _Home({Key? key}) : super(key: key);

  Widget _pageViewItembuilder(BuildContext context, int index) {
    if (index == 0) {
      return const SourceMangasView();
    } else {
      return const SettingView();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    ref.listen<StateController<int>>(
      _currentIndex,
      (value) => pageController.animateToPage(value.state, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn),
    );
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: _pageViewItembuilder,
        itemCount: _bottomNavigationBarItems.length,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        onTap: (index) => ref.read(_currentIndex).state = index,
        currentIndex: ref.watch(_currentIndex).state,
      ),
    );
  }
}

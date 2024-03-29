import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/bloc/hud_bloc.dart';
import 'package:fomic/feature/explore_source/view.dart';
import 'package:fomic/feature/setting/theme_bloc.dart';
import 'package:fomic/feature/setting/view.dart';
import 'package:fomic/l10n/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Fomic extends HookConsumerWidget {
  const Fomic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
    final themeState = ref.watch(ThemeBLoC.provider);
    ref.listen<HUDState>(HUDBLoC.provider, (previous, next) {
      next.when(
        toast: (message, duration) => EasyLoading.showToast(message, duration: duration),
        loading: () => EasyLoading.show(),
        done: () => EasyLoading.dismiss(),
      );
    });
    return MaterialApp(
      title: 'Fomic',
      localizationsDelegates: L10N.localizationsDelegates,
      supportedLocales: L10N.supportedLocales,
      theme: themeState.theme,
      darkTheme: themeState.darkTheme,
      home: const _Home(),
      builder: (context, child) {
        return FlutterEasyLoading(
          child: child,
        );
      },
    );
  }
}

class _Home extends HookConsumerWidget {
  static final _currentIndex = StateProvider((_) => 0);

  const _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(initialPage: ref.read(_currentIndex));
    ref.listen<int>(
      _currentIndex,
      (previous, next) {
        pageController.animateToPage(next, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
      },
    );
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const ExploreSourceView();
            case 1:
              return const SettingView();
            default:
              assert(false, 'No matched index: $index');
              return Container();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore),
            label: L10N.of(context).explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: L10N.of(context).setting,
          ),
        ],
        onTap: (index) => ref.read(_currentIndex.notifier).update((state) => index),
        currentIndex: ref.watch(_currentIndex),
      ),
    );
  }
}

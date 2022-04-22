import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/bloc/hud_bloc.dart';
import 'package:fomic/feature/setting/theme_bloc.dart';
import 'package:fomic/feature/explore_source/view.dart';
import 'package:fomic/feature/setting/view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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

  _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
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
            label: AppLocalizations.of(context)!.explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.setting,
          ),
        ],
        onTap: (index) => ref.read(_currentIndex.notifier).update((state) => index),
        currentIndex: ref.watch(_currentIndex),
      ),
    );
  }
}

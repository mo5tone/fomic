import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/state/hud_state.dart';
import 'package:fomic/common/state/theme_state.dart';
import 'package:fomic/common/constant/routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Fomic extends HookWidget {
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
    final themeState = useProvider(rpThemeStateNotifier.state);
    return ProviderListener(
      provider: rpHUDStateNotifier.state,
      onChange: (context, HUDState value) {
        if (value.loading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
        if (value.message != null && value.message.isNotEmpty) {
          EasyLoading.showToast(value.message);
        }
      },
      child: MaterialApp(
        title: 'Fomic',
        theme: themeState.theme,
        darkTheme: themeState.darkTheme,
        routes: Map.fromEntries(Routing.values.map((e) => e.route)),
        builder: (context, child) {
          return FlutterEasyLoading(
            child: child,
          );
        },
      ),
    );
  }
}

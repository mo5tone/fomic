import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fomic/model/constant/routing.dart';
import 'package:fomic/scene/common/view_model/tab_navigation_view_model.dart';
import 'package:fomic/scene/setting/view_model/theme_change_notifier.dart';
import 'package:fomic/utils/injector.dart';
import 'package:provider/provider.dart';

void main() {
  Injector.register();
  runApp(Fomic());
}

class Fomic extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance..maskType = EasyLoadingMaskType.clear;
    return Material(
      type: MaterialType.transparency,
      child: FlutterEasyLoading(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeChangeNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) => TabNavigationViewModel(),
            ),
          ],
          child: _App(),
        ),
      ),
    );
  }
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeChangeNotifier value) => value.theme);
    final darkTheme = context.select((ThemeChangeNotifier value) => value.darkTheme);
    return MaterialApp(
      title: 'Fomic',
      theme: theme,
      darkTheme: darkTheme,
      routes: Map.fromEntries(Routing.values.map((e) => e.route)),
    );
  }
}

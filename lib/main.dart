import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fomic/model/constant/route_name.dart';
import 'package:fomic/scene/common/view_model/tab_navigation_view_model.dart';
import 'package:fomic/scene/setting/view_model/brightness_change_notifier.dart';
import 'package:i18n_extension/i18n_widget.dart';
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
    return I18n(
      child: Material(
        type: MaterialType.transparency,
        child: FlutterEasyLoading(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => BrightnessChangeNotifier(),
              ),
              ChangeNotifierProvider(
                create: (_) => TabNavigationViewModel(),
              ),
            ],
            child: _App(),
          ),
        ),
      ),
    );
  }
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = context.select((BrightnessChangeNotifier value) => value.brightness);
    return MaterialApp(
      title: 'Fomic',
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
      ],
      theme: ThemeData(
        brightness: brightness ?? Brightness.light,
      ),
      darkTheme: brightness == null ? ThemeData.dark() : null,
      routes: Map.fromEntries(RouteName.values.map((e) => e.route)),
    );
  }
}

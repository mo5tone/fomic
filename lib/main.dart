import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fomic/scene/common/view/bottom_navigation_view.dart';
import 'package:fomic/scene/common/view_model/bottom_navigation_view_model.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';

import 'utils/injector.dart';

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
          child: _Fomic(),
        ),
      ),
    );
  }
}

class _Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      theme: ThemeData.light(),
      home: ChangeNotifierProvider(
        create: (_) => BottomNavigationViewModel(),
        child: BottomNavigationView(),
      ),
    );
  }
}

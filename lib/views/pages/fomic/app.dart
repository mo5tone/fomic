import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fomic/blocs/base/delegate.dart';
import 'package:fomic/common/util/router.dart';
import 'package:fomic/generated/i18n.dart';
import 'package:fomic/views/pages/home/page.dart';

class Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = FomicBlocDelegate();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fomic',
      theme: ThemeData(
        brightness: Brightness.light,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      onUnknownRoute: Router.unknownRoute,
      onGenerateRoute: Router.generateRoute,
      home: HomePage(),
    );
  }
}

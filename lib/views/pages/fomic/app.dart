import 'package:bloc/bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fomic/blocs/base/delegate.dart';
import 'package:fomic/generated/i18n.dart';
import 'package:fomic/views/pages/home/page.dart';

class Fomic extends StatelessWidget {
  static final router = Router();

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = FomicBlocDelegate();
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(
        brightness: Brightness.dark,
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
      onGenerateRoute: router.generator,
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fomic/scene/books/viewmodel/books_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/constant/repository_id.dart';
import 'utils/injector.dart';
import 'scene/books/view/books_view.dart';

void main() {
  Injector.register();
  runApp(Fomic());
}

class Fomic extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.maShanZhengTextTheme(Theme.of(context).textTheme),
        primaryTextTheme: GoogleFonts.maShanZhengTextTheme(Theme.of(context).primaryTextTheme),
        accentTextTheme: GoogleFonts.maShanZhengTextTheme(Theme.of(context).accentTextTheme),
      ),
      builder: (ctx, child) => Material(
        type: MaterialType.transparency,
        child: FlutterEasyLoading(
          child: ChangeNotifierProvider(
            create: (_) => BooksViewModel(RepositoryID.bnmanhua),
            child: BooksView(),
          ),
        ),
      ),
    );
  }
}

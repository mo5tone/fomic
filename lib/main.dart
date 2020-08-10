import 'package:flutter/material.dart';
import 'package:fomic/scene/books/viewmodel/BooksViewModel.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'model/constant/SourceId.dart';
import 'utils/Injector.dart';
import 'scene/books/view/BooksView.dart';

void main() {
  Injector.setup();
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
      ),
      home: ChangeNotifierProvider(
        create: (ctx) => GetIt.I.get<BooksViewModel>(param1: SourceId.bnmanhua),
        builder: (ctx, child) => BooksView(),
      ),
    );
  }
}

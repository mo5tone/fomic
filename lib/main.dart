import 'package:flutter/material.dart';
import 'package:fomic/scene/books/viewmodel/books_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'model/constant/repository_id.dart';
import 'utils/injector.dart';
import 'scene/books/view/books_view.dart';

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
        create: (ctx) => GetIt.I.get<BooksViewModel>(param1: RepositoryID.bnmanhua),
        builder: (ctx, child) => BooksView(),
      ),
    );
  }
}

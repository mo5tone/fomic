import 'package:flutter/material.dart';

import 'model/constant/SourceName.dart';
import 'injector/Injector.dart';
import 'scene/books/view/BooksView.dart';

void main() {
  Injector.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BooksView(sourceName: SourceName.dmzj),
    );
  }
}

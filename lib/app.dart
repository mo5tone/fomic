import 'package:flutter/material.dart';
import 'package:fomic/source/dmzj/dmzj.dart';
import 'package:fomic/source/manhuaren/manhuaren.dart';

import 'remote_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sources = [
      Dmzj(),
//      Manhuaren(),
    ];
    print(DateTime.now().millisecondsSinceEpoch);
    var repository = RemoteRepository(sources);
    repository
        .fetchComics()
        .then((comics) => comics.map((comic) => comic.source.fetchComic(comic)))
        .then((comics) {
      Future.wait(comics)
          .then((comics) => comics.where((comic) => comic != null).first)
          .then((comic) async => await comic.source.fetchChapters(comic))
          .then((chapters) => print(chapters));
    });
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fomic'),
        ),
        body: Center(
          child: const Text('Hello there!'),
        ),
      ),
    );
  }
}

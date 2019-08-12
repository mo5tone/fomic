import 'dart:convert' as convert;

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/views/pages/comic/page.dart';
import 'package:fomic/views/pages/uploads/page.dart';

class Routes {
  static final Routes _instance = Routes._();

  Router _router;

  Routes._() {
    _router = Router();
    _router.notFoundHandler = Handler(
      handlerFunc: (context, params) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Wooops'),
          ),
          body: SafeArea(
              child: Center(
            child: Text(
              'Not found.',
              style: Theme.of(context).textTheme.headline,
            ),
          )),
        );
      },
    );
    <String, Handler>{
      '/manga/:source/:manga': Handler(
        handlerFunc: (context, params) {
          final sourceIdIndex = int.parse(params['manga'][0]);
          assert(sourceIdIndex != null);
          assert(sourceIdIndex < SourceId.values.length);
          final source = Source.of(SourceId.values[sourceIdIndex]);
          final manga = Manga.fromJson(convert.jsonDecode(params['manga'][0]));
          return ComicPage(comic: manga);
        },
      ),
      '/upload': Handler(
        handlerFunc: (context, params) {
          return UploadsPage();
        },
      ),
    }.forEach((path, handler) {
      _router.define(path, handler: handler);
    });
  }

  static Future navigateTo(
    BuildContext context,
    String path, {
    bool replace = false,
    bool clearStack = false,
    TransitionType transition,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder,
  }) {
    return _instance._router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
    );
  }
}

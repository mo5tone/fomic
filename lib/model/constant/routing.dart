import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/source/source.dart';
import 'package:fomic/scene/books/view/books_view.dart';
import 'package:fomic/scene/books/view_model/books_view_model.dart';
import 'package:fomic/scene/chapters/view/chapters_view.dart';
import 'package:fomic/scene/chapters/view_model/chapters_view_model.dart';
import 'package:fomic/scene/common/view/tab_navigation_view.dart';
import 'package:provider/provider.dart';

enum Routing {
  initial,
  books,
  chapters,
}

extension RoutingEx on Routing {
  String get name {
    var name = '/error';
    switch (this) {
      case Routing.initial:
        name = '/';
        break;
      default:
        name = '/${describeEnum(this)}';
        break;
    }
    return name;
  }

  MapEntry<String, Widget Function(BuildContext)> get route {
    Widget Function(BuildContext) value;
    switch (this) {
      case Routing.initial:
        value = (context) => TabNavigationView();
        break;
      case Routing.books:
        value = (context) {
          final arguments = ModalRoute.of(context).settings.arguments;
          assert(arguments is SourceID);
          return ChangeNotifierProvider(
            create: (_) => BooksViewModel(Source.of(arguments)),
            builder: (_, child) => BooksView(),
          );
        };
        break;
      case Routing.chapters:
        value = (context) {
          final arguments = ModalRoute.of(context).settings.arguments as Map;
          final source = arguments['source'];
          final book = arguments['book'];
          assert(source is Source);
          assert(book is Book);
          return ChangeNotifierProvider(
            create: (_) => ChaptersViewModel(source, book),
            builder: (_, child) => ChaptersView(),
          );
        };
        break;
    }
    return MapEntry(name, value);
  }

  Future<T> push<T extends Object>(BuildContext context, {Object arguments}) =>
      Navigator.of(context).pushNamed(name, arguments: arguments);

  Future<T> popAndPush<T extends Object, TO extends Object>(BuildContext context, {TO result, Object arguments}) =>
      Navigator.of(context).popAndPushNamed(name, result: result, arguments: arguments);

  Future<T> pushAndRemoveUntil<T extends Object>(BuildContext context, bool Function(Route<dynamic>) predicate,
          {Object arguments}) =>
      Navigator.of(context).pushNamedAndRemoveUntil(name, predicate, arguments: arguments);

  Future<T> pushReplacement<T extends Object, TO extends Object>(BuildContext context, {TO result, Object arguments}) =>
      Navigator.of(context).pushReplacementNamed(name, result: result, arguments: arguments);
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/scene/books/screen.dart';
import 'package:fomic/scene/chapters/screen.dart';
import 'package:fomic/scene/explore/screen.dart';
import 'package:fomic/scene/main/screen.dart';
import 'package:fomic/scene/pages/screen.dart';
import 'package:fomic/scene/setting/screen.dart';

enum Routing {
  initial,
  books,
  chapters,
  pages,
}

extension RoutingEx on Routing {
  String get name {
    var name = '/${describeEnum(this)}';
    if (this == Routing.initial) {
      name = '/';
    }
    return name;
  }

  MapEntry<String, Widget Function(BuildContext)> get route {
    Widget Function(BuildContext) value;
    switch (this) {
      case Routing.initial:
        value = (context) => MainScreen(
              builder: (context, index) {
                Widget child;
                switch (index) {
                  case 0:
                    child = ExploreScreen();
                    break;
                  case 1:
                    child = SettingScreen();
                    break;
                  default:
                    break;
                }
                return child;
              },
              bottomNavigationBarItems: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting',
                ),
              ],
            );
        break;
      case Routing.books:
        value = (context) => BooksScreen();
        break;
      case Routing.chapters:
        value = (context) {
          final arguments = ModalRoute.of(context).settings.arguments as Map;
          final book = arguments['book'];
          assert(book is Book);
          return ChaptersScreen(book: book);
        };
        break;
      case Routing.pages:
        value = (context) {
          final arguments = ModalRoute.of(context).settings.arguments as Map;
          final book = arguments['book'];
          final chapter = arguments['chapter'];
          assert(book is Book);
          assert(chapter is Chapter);
          return PagesScreen(book: book, chapter: chapter);
        };
        break;
    }
    return MapEntry(name, value);
  }

  Future<T> push<T extends Object>(BuildContext context, {Object arguments}) => Navigator.of(context).pushNamed(name, arguments: arguments);

  Future<T> popAndPush<T extends Object, TO extends Object>(BuildContext context, {TO result, Object arguments}) =>
      Navigator.of(context).popAndPushNamed(name, result: result, arguments: arguments);

  Future<T> pushAndRemoveUntil<T extends Object>(BuildContext context, bool Function(Route<dynamic>) predicate, {Object arguments}) =>
      Navigator.of(context).pushNamedAndRemoveUntil(name, predicate, arguments: arguments);

  Future<T> pushReplacement<T extends Object, TO extends Object>(BuildContext context, {TO result, Object arguments}) =>
      Navigator.of(context).pushReplacementNamed(name, result: result, arguments: arguments);
}

import 'package:flutter/material.dart';
import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/scene/books/view/books_view.dart';
import 'package:fomic/scene/books/view_model/books_view_model.dart';
import 'package:fomic/scene/common/view/tab_navigation_view.dart';
import 'package:provider/provider.dart';

enum RouteName {
  initial,
  books,
}

extension RouteNameEx on RouteName {
  String get name {
    var name = '/error';
    switch (this) {
      case RouteName.initial:
        name = '/';
        break;
      case RouteName.books:
        name = '/books';
        break;
    }
    return name;
  }

  MapEntry<String, Widget Function(BuildContext)> get route {
    Widget Function(BuildContext) value;
    switch (this) {
      case RouteName.initial:
        value = (context) => TabNavigationView();
        break;
      case RouteName.books:
        value = (context) {
          final arguments = ModalRoute.of(context).settings.arguments;
          assert(arguments is SourceID);
          return ChangeNotifierProvider(
            create: (_) => BooksViewModel(arguments),
            builder: (_, child) => BooksView(),
          );
        };
        break;
    }
    return MapEntry(name, value);
  }
}

extension NavigatorStateEx on NavigatorState {
  Future<T> pushName<T extends Object>(RouteName name, {Object arguments}) {
    return pushNamed(name.name, arguments: arguments);
  }

  Future<T> pushReplacementName<T extends Object, TO extends Object>(RouteName name, {TO result, Object arguments}) {
    return pushReplacementNamed(name.name, result: result, arguments: arguments);
  }

  Future<T> pushNameAndRemoveUntil<T extends Object>(RouteName name, bool Function(Route<dynamic>) predicate,
      {Object arguments}) {
    return pushNamedAndRemoveUntil(name.name, predicate, arguments: arguments);
  }

  Future<T> popAndPushName<T extends Object, TO extends Object>(RouteName name, {TO result, Object arguments}) {
    return popAndPushNamed(name.name, result: result, arguments: arguments);
  }
}

import 'package:flutter/material.dart';
import 'package:fomic/views/pages/book/page.dart';
import 'package:fomic/views/pages/chapter/page.dart';
import 'package:fomic/views/pages/upload/page.dart';

class Router {
  Router._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> route;
    switch (settings.name) {
      case '/upload':
        route = MaterialPageRoute<void>(
          builder: (context) {
            return UploadPage();
          },
          fullscreenDialog: true,
        );
        break;
      case '/book':
        route = MaterialPageRoute<void>(
          builder: (context) {
            return BookPage(book: settings.arguments);
          },
        );
        break;
      case '/chapter':
        route = MaterialPageRoute<void>(
          builder: (context) {
            return ChapterPage(chapter: settings.arguments);
          },
        );
        break;
      default:
        break;
    }
    return route;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (context) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Wooops'),
          ),
          body: SafeArea(
            child: Center(
              child: Text(
                'Not Found.',
                style: theme.textTheme.headline,
              ),
            ),
          ),
        );
      },
    );
  }
}

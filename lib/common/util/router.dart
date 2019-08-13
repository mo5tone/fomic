import 'package:flutter/material.dart';
import 'package:fomic/views/pages/manga/page.dart';
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
      case '/manga':
        route = MaterialPageRoute<void>(
          builder: (context) {
            return MangaPage(
              manga: settings.arguments,
            );
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
        return Scaffold(
          appBar: AppBar(
            title: Text('Wooops'),
          ),
          body: SafeArea(
            child: Center(
              child: Text(
                'Not Found.',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
        );
      },
    );
  }
}

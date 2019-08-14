import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/upload/bloc.dart';
import 'package:fomic/blocs/upload/state.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:http_server/http_server.dart';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => UploadsBloc(),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  UploadsBloc bloc;
  Future<HttpServer> httpServer;

  Future<HttpServer> startHttpServer() async {
    stopHttpServer();
    if (!await utils.isWifi) {
      return Future.value(null);
    }
    return runZoned(
      () => HttpServer.bind('0.0.0.0', 8000)
        ..then((server) {
          server.transform(HttpBodyHandler()).listen((request) async {
            final response = request.request.response;
            switch (request.request.uri.toString()) {
              case '/upload':
                if (request.type != "form") {
                  response.statusCode = 400;
                  response.write({
                    'error': 'Incorrect request type: ${request.type}.',
                  });
                  response.close();
                  return;
                }
                List.from(request.body.values
                        .where((value) => value is HttpBodyFileUpload))
                    .forEach((data) async {
                  final directory = await getApplicationDocumentsDirectory();
                  File('${directory.path}/upload/${data.filename}')
                    ..createSync(recursive: true)
                    ..writeAsBytesSync(data.content);
                });
                response.statusCode = 201;
                response.close();
                break;
              case '/':
                response.statusCode = 200;
                response.headers
                    .set("Content-Type", "text/html; charset=utf-8");
                response.write(await DefaultAssetBundle.of(context)
                    .loadString('assets/html/index.html'));
                response.close();
                break;
              default:
                response.statusCode = 404;
                response.write({
                  'error': 'Not found.',
                });
                response.close();
                break;
            }
          });
        }),
      onError: (e, stackTrace) => print('Error: $e, StackTrace: $stackTrace'),
    );
  }

  void stopHttpServer({bool force = false}) {
    if (httpServer != null) {
      httpServer.then((server) => server?.close(force: force));
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UploadsBloc>(context);
  }

  @override
  void dispose() {
    stopHttpServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadsBloc, UploadsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // todo: check mini server is running and close it.
                Navigator.of(context).pop();
              },
            ),
            title: Text.rich(
              TextSpan(
                text: 'Uploads',
                style: Theme.of(context).textTheme.title,
                children: [
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'IP Address: 127.0.0.1',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  Navigator.of(context).pushNamed('hello');
                  // todo: start or end mini server.
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Container(),
          ),
        );
      },
    );
  }
}

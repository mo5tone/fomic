import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/sources/bloc.dart';
import 'package:fomic/blocs/sources/event.dart';
import 'package:fomic/blocs/sources/state.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/views/pages/comic/page.dart';
import 'package:fomic/views/widgets/comic_widget.dart';
import 'package:fomic/views/widgets/filters_widget.dart';
import 'package:http_server/http_server.dart';
import 'package:path_provider/path_provider.dart';

class SourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return SourcesBloc()..dispatch(SourcesEvent(SourcesEventType.fetch));
      },
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SourcesBloc bloc;
  ScrollController scrollController;
  TextEditingController textEditingController;

  void scrollControllerListener() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final extentBefore = scrollController.position.extentBefore;
    if (extentBefore == maxScrollExtent) {
      bloc.dispatch(SourcesEvent(SourcesEventType.more));
    }
  }

  void textEditingControllerListener() {
    // todo
  }

  Future _startWebServer() async {
    final connectivity = Connectivity();
    connectivity.checkConnectivity().then((result) {
      print('result: $result');
      return connectivity.getWifiIP();
    }).then((ip) {
      print('ip: $ip');
    }).catchError((error) {
      print('error: $error');
    });
    runZoned(() {
      HttpServer.bind('0.0.0.0', 8000).then((server) {
        server.transform(HttpBodyHandler()).listen((request) async {
          switch (request.request.uri.toString()) {
            case '/upload':
              if (request.type != "form") {
                request.request.response.statusCode = 400;
                request.request.response.close();
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
              request.request.response.statusCode = 201;
              request.request.response.close();
              break;
            case '/':
              String _content = await DefaultAssetBundle.of(context)
                  .loadString('assets/html/index.html');
              request.request.response.statusCode = 200;
              request.request.response.headers
                  .set("Content-Type", "text/html; charset=utf-8");
              request.request.response.write(_content);
              request.request.response.close();
              break;
            default:
              request.request.response.statusCode = 404;
              request.request.response.write('Not found');
              request.request.response.close();
              break;
          }
        });
      });
    }, onError: (e, stackTrace) => print('Error: $e, StackTrace: $stackTrace'));
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SourcesBloc>(context);
    scrollController = ScrollController()
      ..addListener(scrollControllerListener);
    textEditingController = TextEditingController()
      ..addListener(textEditingControllerListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcesBloc, SourcesState>(
      builder: (context, state) {
        final appBar = state.searching
            ? AppBar(
                title: TextField(
                  textInputAction: TextInputAction.search,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Keyword to search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        bloc.dispatch(
                            SourcesEvent(SourcesEventType.endSearching));
                      },
                    ),
                  ),
                  onSubmitted: (text) {
                    scrollController.animateTo(
                      0,
                      curve: Curves.bounceInOut,
                      duration: Duration(milliseconds: 300),
                    );
                    bloc.dispatch(SourcesEvent(
                      SourcesEventType.fetch,
                      query: text,
                    ));
                  },
                ),
              )
            : AppBar(
                leading: IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                ),
                title: Text('${Source.of(state.sourceId).name}'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      bloc.dispatch(
                          SourcesEvent(SourcesEventType.beginSearching));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      scaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                ],
              );
        return Scaffold(
          key: scaffoldKey,
          appBar: appBar,
          drawer: state.searching
              ? null
              : Drawer(
                  child: ListView.builder(
                    itemCount: SourceId.values.length,
                    itemBuilder: (context, index) {
                      final source = Source.of(SourceId.values[index]);
                      return ListTile(
                        onTap: () {
                          textEditingController.clear();
                          bloc.dispatch(SourcesEvent(
                            SourcesEventType.displaySource,
                            sourceId: source.id,
                          ));
                          Navigator.of(context).pop();
                        },
                        title: Text(source.name),
                        trailing: Switch(
                          value: source.available,
                          onChanged: (value) {
                            bloc.dispatch(SourcesEvent(
                              value
                                  ? SourcesEventType.enableSource
                                  : SourcesEventType.disableSource,
                              sourceId: source.id,
                            ));
                          },
                        ),
                      );
                    },
                  ),
                ),
          endDrawer: state.searching
              ? null
              : Drawer(
                  child: FiltersWidget(
                    filters: state.filters,
                    onApply: () {
                      textEditingController.clear();
                      bloc.dispatch(SourcesEvent(
                        SourcesEventType.fetch,
                        filters: state.filters,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
          body: SafeArea(
            child: Stack(
              children: [
                IgnorePointer(
                  ignoring: state.type == SourcesStateType.fetching,
                  child: Container(
                    child: RefreshIndicator(
                      child: GridView.builder(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        controller: scrollController,
                        itemCount: state.comics.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 10 / 13,
                        ),
                        itemBuilder: (context, index) {
                          return ComicWidget(
                            comic: state.comics[index],
                            onTap: () {
                              final route = MaterialPageRoute<void>(
                                builder: (context) {
                                  return ComicPage(comic: state.comics[index]);
                                },
                              );
                              Navigator.of(context).push(route);
                            },
                          );
                        },
                      ),
                      onRefresh: () {
                        return Future(() {
                          bloc.dispatch(SourcesEvent(
                            SourcesEventType.fetch,
                            query: state.query,
                            filters: state.filters,
                          ));
                        });
                      },
                    ),
                  ),
                ),
                if (state.type == SourcesStateType.fetching)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          floatingActionButton: state.sourceId == SourceId.local
              ? IgnorePointer(
                  ignoring: state.type == SourcesStateType.fetching,
                  child: FloatingActionButton(
                    onPressed: () {
                      // todo: add local files
                      _startWebServer();
                    },
                    child: Icon(Icons.add),
                  ),
                )
              : null,
        );
      },
    );
  }
}

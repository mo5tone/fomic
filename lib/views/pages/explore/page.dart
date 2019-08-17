import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/explore/bloc.dart';
import 'package:fomic/blocs/explore/event.dart';
import 'package:fomic/blocs/explore/state.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/views/widgets/book_grid_view_item.dart';
import 'package:fomic/views/widgets/filters_drawer.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return SourcesBloc()..dispatch(SourcesEvent.fetch());
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
      bloc.dispatch(SourcesEvent.more());
    }
  }

  void textEditingControllerListener() {
    // todo
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
        final appBar = state.isSearchMode
            ? AppBar(
                title: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Keyword to search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        bloc.dispatch(SourcesEvent.toggleSearchMode());
                      },
                    ),
                  ),
                  onSubmitted: (text) {
                    scrollController.animateTo(
                      0,
                      curve: Curves.bounceInOut,
                      duration: Duration(milliseconds: 300),
                    );
                    bloc.dispatch(SourcesEvent.fetch(query: text));
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
                      bloc.dispatch(SourcesEvent.toggleSearchMode());
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
        final drawer = state.isSearchMode
            ? null
            : Drawer(
                child: ListView.builder(
                  itemCount: SourceId.values.length,
                  itemBuilder: (context, index) {
                    final source = Source.of(SourceId.values[index]);
                    return ListTile(
                      onTap: () {
                        textEditingController.clear();
                        bloc.dispatch(SourcesEvent.displaySource(source.id));
                        Navigator.of(context).pop();
                      },
                      title: Text(source.name),
                      trailing: Switch(
                        value: source.available,
                        onChanged: (value) {
                          bloc.dispatch(SourcesEvent.toggleSource(source.id));
                        },
                      ),
                    );
                  },
                ),
              );
        final endDrawer = state.isSearchMode
            ? null
            : FiltersDrawer(
                filters: state.filters,
                onApply: () {
                  textEditingController.clear();
                  bloc.dispatch(SourcesEvent.fetch());
                  Navigator.of(context).pop();
                },
              );
        final onRefresh = () => Future(() {
              bloc.dispatch(SourcesEvent.fetch(query: state.query));
            });
        return Scaffold(
          key: scaffoldKey,
          appBar: appBar,
          drawer: drawer,
          endDrawer: endDrawer,
          body: SafeArea(
            child: Stack(
              children: [
                IgnorePointer(
                  ignoring: state.isFetching,
                  child: Container(
                    child: RefreshIndicator(
                      child: GridView.builder(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        controller: scrollController,
                        itemCount: state.books.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 10 / 13,
                        ),
                        itemBuilder: (context, index) {
                          return BookGridViewItem(
                            book: state.books[index],
                            onTap: (book) => Navigator.of(context).pushNamed(
                              '/book',
                              arguments: book,
                            ),
                          );
                        },
                      ),
                      onRefresh: onRefresh,
                    ),
                  ),
                ),
                if (state.isFetching)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          floatingActionButton: state.sourceId == SourceId.local
              ? IgnorePointer(
                  ignoring: state.isFetching,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/upload');
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/sources/bloc.dart';
import 'package:fomic/blocs/sources/event.dart';
import 'package:fomic/blocs/sources/state.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/views/widgets/comic_widget.dart';
import 'package:fomic/views/widgets/filters_widget.dart';

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

  PreferredSizeWidget appBar(BuildContext context, SourcesState state) {
    if (state.searching) {
      return AppBar(
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
                bloc.dispatch(SourcesEvent(SourcesEventType.endSearching));
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
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.tune),
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
        title: Text('${Source.of(state.sourceId).name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.dispatch(SourcesEvent(SourcesEventType.beginSearching));
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
    }
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
        return Scaffold(
          key: scaffoldKey,
          appBar: appBar(context, state),
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
                          return ComicWidget(comic: state.comics[index]);
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
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/comic/screen.dart';
import 'package:fomic/comics/bloc.dart';
import 'package:fomic/comics/event.dart';
import 'package:fomic/comics/state.dart';
import 'package:fomic/comics/widget/comic_widget.dart';
import 'package:fomic/common/helper/pair.dart';
import 'package:fomic/model/comic.dart';
import 'package:fomic/model/filter.dart';

class ComicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        final bloc = ComicsBloc();
        if (bloc.currentState.comics.isEmpty) {
          bloc.dispatch(ComicsEvent(ComicsEventType.refresh));
        }
        return bloc;
      },
      child: _ComicsPage(),
    );
  }
}

class _ComicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ComicsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics'),
      ),
      body: SafeArea(
        child: BlocBuilder<ComicsBloc, ComicsState>(
          builder: (context, state) {
            List<Comic> comics = state.comics;
            if (comics.isEmpty) {
              if (state.type == ComicsStateType.fetching) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.type == ComicsStateType.fetchFailure) {
                return Center(
                  child: Text('${state.error}'),
                );
              }
            }
            final scrollController = ScrollController();
            scrollController.addListener(() {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                bloc.dispatch(ComicsEvent(ComicsEventType.loadMore));
              }
            });
            return Container(
              padding: EdgeInsets.only(
                top: 8,
                right: 8,
                left: 8,
              ),
              child: RefreshIndicator(
                child: GridView.builder(
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 10 / 13,
                  ),
                  itemBuilder: (context, index) => ComicWidget(
                    comic: comics[index],
                    onTap: () {
                      final route = MaterialPageRoute<void>(
                        builder: (context) => ComicScreen(
                          comic: comics[index],
                        ),
                      );
                      Navigator.of(context, rootNavigator: true).push(route);
                    },
                    onLongPress: () {
                      // todo: add to favorites
                    },
                  ),
                  itemCount: comics.length,
                ),
                onRefresh: () => Future(
                    () => bloc.dispatch(ComicsEvent(ComicsEventType.refresh))),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          final route = MaterialPageRoute<Pair<String, List<Filter>>>(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text('Search'),
              ),
              body: Container(),
            ),
          );
          Navigator.of(context, rootNavigator: true)
              .push(route)
              .then((pair) => bloc.dispatch(ComicsEvent(
                    ComicsEventType.refresh,
                    query: pair.first ?? '',
                    filters: pair.second ?? [],
                  )));
        },
      ),
    );
  }
}

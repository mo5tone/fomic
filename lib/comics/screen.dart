import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/model/comic.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class ComicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ComicsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics'),
      ),
      body: SafeArea(
        child: BlocBuilder(
          builder: (context, ComicsState state) {
            final comics = state.comics;
            ScrollController scrollController = ScrollController();
            scrollController.addListener(() {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                bloc.dispatch(ComicsEventLoadMore());
              }
            });
            if (comics.isEmpty) {
              if (state is ComicsStateFetchFailure) {
                return Center(
                  child: Text('${state.error}'),
                );
              } else if (state is ComicsStateFetching) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            return RefreshIndicator(
              child: GridView.builder(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => _ComicWidget(
                  comic: state.comics[index],
                ),
                itemCount: state.comics.length,
              ),
              onRefresh: () =>
                  Future(() => bloc.dispatch(ComicsEventRefresh())),
            );
          },
          bloc: bloc,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            print('Search!!!!');
          }),
    );
  }
}

class _ComicWidget extends StatelessWidget {
  final Comic comic;

  const _ComicWidget({
    Key key,
    @required this.comic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Theme.of(context).disabledColor,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: comic.thumbnailUrl ?? '',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.broken_image,
                ),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print('$comic');
      },
    );
  }
}

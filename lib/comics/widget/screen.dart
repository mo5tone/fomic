import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/model/comic.dart';

import 'package:fomic/comics/bloc/bloc.dart';
import 'package:fomic/comics/bloc/event.dart';
import 'package:fomic/comics/bloc/state.dart';

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
            return Container(
              padding: EdgeInsets.only(top: 8),
              child: RefreshIndicator(
                child: GridView.builder(
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) => _ComicWidget(
                    comic: state.comics[index],
                  ),
                  itemCount: state.comics.length,
                ),
                onRefresh: () =>
                    Future(() => bloc.dispatch(ComicsEventRefresh())),
              ),
            );
          },
          bloc: bloc,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            // todo: navigate to search screen
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
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _ComicCoverWidget(
                    comic: comic,
                  ),
                  flex: 10,
                ),
                Expanded(
                  flex: 3,
                  child: _ComicInfoWidget(
                    comic: comic,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // todo: navigate to comic detail screen
      },
      onLongPress: () {
        // todo: add comic to favorites
      },
    );
  }
}

class _ComicCoverWidget extends StatelessWidget {
  final Comic comic;

  const _ComicCoverWidget({
    Key key,
    @required this.comic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(math.pi / -4)..translate(0.0, -190.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            color: Theme.of(context).primaryColor,
            child: Text('${comic.source.name}'),
          ),
        )
      ],
    );
  }
}

class _ComicInfoWidget extends StatelessWidget {
  final Comic comic;

  const _ComicInfoWidget({
    Key key,
    @required this.comic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '${comic.title}',
            maxLines: 1,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '${comic.author}',
                  maxLines: 1,
                ),
              ),
              Text('${comic.status}'),
            ],
          )
        ],
      ),
    );
  }
}

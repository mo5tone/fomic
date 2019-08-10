import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/comic/bloc.dart';
import 'package:fomic/blocs/comic/event.dart';
import 'package:fomic/blocs/comic/state.dart';
import 'package:fomic/model/comic.dart';

class ComicPage extends StatelessWidget {
  final Comic comic;

  const ComicPage({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return ComicBloc(comic)..dispatch(ComicEvent(ComicEventType.fetch));
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
  ComicBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ComicBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarExpandedHeight = MediaQuery.of(context).size.height / 3;
    return BlocBuilder<ComicBloc, ComicState>(
      builder: (context, state) {
        final backgroundImage = Hero(
          tag: '${state.comic.source.id.index}${state.comic.url}',
          child: CachedNetworkImage(
            useOldImageOnUrlChange: true,
            imageUrl: state.comic.thumbnailUrl ?? '',
            errorWidget: (context, url, error) => Icon(
              Icons.broken_image,
              color: Theme.of(context).errorColor,
            ),
            fit: BoxFit.cover,
          ),
        );
        final blurMask = BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
            ),
          ),
        );
        final description = Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: appBarExpandedHeight - kToolbarHeight,
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'Summary: ${state.comic.description}',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'Authors: ${state.comic.author}',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'Genre: ${state.comic.genre}',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              )),
            ),
          ),
        );
        return Scaffold(
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(state.comic.title),
                  expandedHeight: appBarExpandedHeight,
                  pinned: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        print('favorite');
                      },
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      overflow: Overflow.visible,
                      children: [
                        backgroundImage,
                        blurMask,
                        description,
                      ],
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        child: Center(
                          child: Text('${state.chapters[index].name}'),
                        ),
                      );
                    },
                    childCount: state.chapters.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 4 / 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

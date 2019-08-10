import 'dart:math' as math;
import 'dart:ui' as ui;

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
  ScrollController scrollController;

  void scrollControllerListener() {}

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ComicBloc>(context);
    scrollController = ScrollController()
      ..addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarExpandedHeight = MediaQuery.of(context).size.height / 3;
    return BlocBuilder<ComicBloc, ComicState>(
      builder: (context, state) {
        var extraHeight = 0.0;
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
          filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
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
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${state.comic.title}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Summary: ${state.comic.description}',
                      style: Theme.of(context).textTheme.subtitle,
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
                ),
              ),
            ),
          ),
        );
        return Scaffold(
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: appBarExpandedHeight,
                  pinned: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        // todo: add to favorites.
                      },
                    )
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      extraHeight = math.max(extraHeight,
                          constraints.biggest.height - appBarExpandedHeight);
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: constraints.biggest.height ==
                                  kToolbarHeight + extraHeight
                              ? 1.0
                              : 0.0,
                          child: Text(state.comic.title),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            backgroundImage,
                            blurMask,
                            description,
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(8),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final chapter = state.chapters[index];
                        return GestureDetector(
                          onTap: () {
                            // todo: navigate to chapter page
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                color: Theme.of(context).cardColor,
                                child: Center(
                                  child: Text(
                                    chapter.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.chapters.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 4 / 1,
                    ),
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

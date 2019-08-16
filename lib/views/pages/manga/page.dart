import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/manga/bloc.dart';
import 'package:fomic/blocs/manga/event.dart';
import 'package:fomic/blocs/manga/state.dart';
import 'package:fomic/model/manga.dart';

class MangaPage extends StatelessWidget {
  final Manga manga;

  const MangaPage({Key key, this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return MangaBloc(manga)..dispatch(MangaEvent.fetch());
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
  MangaBloc _bloc;
  ScrollController _scrollController;

  ThemeData get _theme => Theme.of(context);

  void _scrollControllerListener() {}

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<MangaBloc>(context);
    _scrollController = ScrollController()
      ..addListener(_scrollControllerListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarExpandedHeight = MediaQuery.of(context).size.height / 3;
    return BlocBuilder<MangaBloc, MangaState>(
      builder: (context, state) {
        final statusBarHeight = MediaQuery.of(context).padding.top;
        final backgroundImage = Hero(
          tag: '${state.manga.sourceId.index}${state.manga.url}',
          child: CachedNetworkImage(
            useOldImageOnUrlChange: true,
            imageUrl: state.manga.thumbnailUrl ?? '',
            errorWidget: (context, url, error) => Icon(
              Icons.broken_image,
              color: _theme.errorColor,
            ),
            fit: BoxFit.cover,
          ),
        );
        final blurMask = BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: _theme.backgroundColor.withOpacity(0.5),
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
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${state.manga.title}',
                      style: _theme.textTheme.title,
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Summary: ${state.manga.description}',
                      style: _theme.textTheme.subtitle,
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Authors: ${state.manga.author}',
                      style: _theme.textTheme.body1,
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Genre: ${state.manga.genre}',
                      style: _theme.textTheme.body1,
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
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: appBarExpandedHeight,
                  pinned: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        _bloc.dispatch(MangaEvent.favorite());
                        // todo: add to favorites.
                      },
                    )
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          duration: kThemeChangeDuration,
                          opacity: constraints.biggest.height ==
                                  kToolbarHeight + statusBarHeight
                              ? 1.0
                              : 0.0,
                          child: Text(state.manga.title),
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
                        final chapter = state.chapterList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/reading',
                              arguments: state.chapterList[index],
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: _theme.disabledColor,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                color: _theme.cardColor,
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
                      childCount: state.chapterList.length,
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

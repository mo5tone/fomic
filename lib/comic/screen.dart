import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/comic/event.dart';
import 'package:fomic/common/util/utils.dart' as utils;
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/comic.dart';

import 'bloc.dart';
import 'state.dart';

class ComicScreen extends StatelessWidget {
  final Comic comic;

  const ComicScreen({
    Key key,
    @required this.comic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) =>
          ComicBloc(comic)..dispatch(ComicEvent(ComicEventType.refresh)),
      child: _ComicPage(),
    );
  }
}

class _ComicPage extends StatelessWidget {
  PreferredSizeWidget appBarWidget(BuildContext context, ComicState state) {
    var bloc = BlocProvider.of<ComicBloc>(context);
    return AppBar(
      title: Text('Comic'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => bloc.dispatch(ComicEvent(ComicEventType.refresh))),
      ],
    );
  }

  Widget headerWidget(BuildContext context, ComicState state) {
    Widget coverWidget(BuildContext context, ComicState state) {
      return Hero(
        tag: 'comic_cover_${state.comic.source.id}_${state.comic.url}',
        child: AspectRatio(
          aspectRatio: 8.0 / 9.0,
          child: CachedNetworkImage(
            imageUrl: state.comic.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget infoWidget(BuildContext context, ComicState state) {
      return Container(
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                  text: '${state.comic.title}',
                  style: Theme.of(context).textTheme.title,
                ),
                TextSpan(
                  text: '\n\n',
                ),
                TextSpan(
                  text: '${state.comic.author}',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                TextSpan(
                  text: '\n\n',
                ),
                TextSpan(
                  text: '${state.comic.genre}',
                ),
                TextSpan(
                  text: '\n\n',
                ),
                TextSpan(
                  text: '${state.comic.description}',
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            coverWidget(context, state),
            Expanded(
              child: infoWidget(context, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusWidget(BuildContext context, ComicState state) {
    var updateAt = utils.dateTime2String(state.latestUpdateAt, 'yyyy-MM-dd');
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text('${state.comic.status}'),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(updateAt),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ComicBloc>(context);
    return BlocBuilder(
      builder: (context, ComicState state) {
        return Scaffold(
          appBar: appBarWidget(context, state),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    headerWidget(context, state),
                    statusWidget(context, state),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 16.0 / 5.0,
                          ),
                          itemBuilder: (context, index) => _ChapterWidget(
                            chapter: state.chapters[index],
                          ),
                          itemCount: state.chapters.length,
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.type == ComicStateType.fetching)
                  AbsorbPointer(
                    child: Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.favorite_border),
            onPressed: () {
              // todo: add to favorite
            },
          ),
        );
      },
      bloc: bloc,
    );
  }
}

class _ChapterWidget extends StatelessWidget {
  final Chapter chapter;
  final void Function() onTap;
  final void Function() onLongPress;

  const _ChapterWidget(
      {Key key, @required this.chapter, this.onTap, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Theme.of(context).disabledColor,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            color: Theme.of(context).cardColor,
            alignment: Alignment.center,
            child: Text(
              '${chapter.name}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ),
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress();
        }
      },
    );
  }
}

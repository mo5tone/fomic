import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/comic.dart';

class ComicWidget extends StatelessWidget {
  final Comic comic;
  final void Function() onTap;
  final void Function() onLongPress;

  const ComicWidget({
    Key key,
    @required this.comic,
    this.onTap,
    this.onLongPress,
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
        Hero(
          tag: '${comic.id.index}${comic.url}',
          child: CachedNetworkImage(
            imageUrl: comic.thumbnailUrl ?? '',
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.broken_image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(math.pi / -4),
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                alignment: Alignment.bottomCenter,
                color: Theme.of(context).primaryColor,
                child: Text(
                  '${comic.id.name}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
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
            style: Theme.of(context).textTheme.subtitle,
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

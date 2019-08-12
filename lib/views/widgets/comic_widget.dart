import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/sources/base/source.dart';

class ComicWidget extends StatelessWidget {
  final Manga comic;
  final void Function() onTap;
  final void Function() onLongPress;

  const ComicWidget({
    Key key,
    @required this.comic,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  Decoration _decoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Theme.of(context).disabledColor,
          offset: Offset(2, 2),
        ),
      ],
    );
  }

  Widget _cover(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: '${comic.sourceId.index}${comic.url}',
          child: CachedNetworkImage(
            imageUrl: comic.thumbnailUrl ?? '',
            placeholder: (context, url) => Image.asset(
              'images/acfun/2018.png',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'images/acfun/2023.png',
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(math.pi / -4),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                alignment: Alignment.bottomCenter,
                color: Theme.of(context).primaryColor,
                child: Text(
                  '${Source.of(comic.sourceId).name}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _info(BuildContext context) {
    var status = 'unknown';
    switch (comic.status) {
      case MangaStatus.ongoing:
        status = 'ongoing';
        break;
      case MangaStatus.completed:
        status = 'completed';
        break;
      case MangaStatus.licensed:
        status = 'licensed';
        break;
      case MangaStatus.unknown:
        status = 'unknown';
        break;
    }
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${comic.title}',
            style: Theme.of(context).textTheme.subtitle,
            maxLines: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${comic.author}',
                  maxLines: 1,
                ),
              ),
              Text(status),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: _decoration(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _cover(context),
                  flex: 10,
                ),
                Expanded(
                  flex: 3,
                  child: _info(context),
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

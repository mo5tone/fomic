import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/manga.dart';
import 'package:fomic/sources/base/source.dart';

class MangaItem extends StatelessWidget {
  final Manga manga;
  final void Function(Manga manga) onTap;
  final void Function(Manga manga) onLongPress;

  String get status {
    var status = 'unknown';
    switch (manga.status) {
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
    return status;
  }

  const MangaItem({
    Key key,
    @required this.manga,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Theme.of(context).disabledColor,
          offset: Offset(2, 2),
        ),
      ],
    );
    final cover = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: '${manga.sourceId.index}${manga.url}',
          child: CachedNetworkImage(
            imageUrl: manga.thumbnailUrl ?? '',
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
                  '${Source.of(manga.sourceId).name}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        )
      ],
    );
    final info = Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${manga.title}',
            style: Theme.of(context).textTheme.subtitle,
            maxLines: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${manga.author}',
                  maxLines: 1,
                ),
              ),
              Text(status),
            ],
          )
        ],
      ),
    );
    return GestureDetector(
      child: Container(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: cover,
                  flex: 10,
                ),
                Expanded(
                  flex: 3,
                  child: info,
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap(manga);
        }
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress(manga);
        }
      },
    );
  }
}

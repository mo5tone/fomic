import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/persistence/database.dart';
import 'package:fomic/sources/base/source.dart';

class BookGridViewItem extends StatelessWidget {
  final Book book;
  final void Function(Book book) onTap;
  final void Function(Book book) onLongPress;

  String get status {
    var status = 'unknown';
    switch (book.bookStatus) {
      case BookStatus.ongoing:
        status = 'ongoing';
        break;
      case BookStatus.completed:
        status = 'completed';
        break;
      case BookStatus.licensed:
        status = 'licensed';
        break;
      case BookStatus.unknown:
        status = 'unknown';
        break;
    }
    return status;
  }

  const BookGridViewItem({
    Key key,
    @required this.book,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: theme.disabledColor,
          offset: Offset(2, 2),
        ),
      ],
    );
    final cover = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: '${book.sourceIdentity.index}${book.url}',
          child: CachedNetworkImage(
            imageUrl: book.thumbnailUrl ?? '',
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
                color: theme.primaryColor,
                child: Text(
                  Source.of(book.sourceIdentity).name,
                  style: theme.textTheme.caption,
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
            '${book.title}',
            style: theme.textTheme.subtitle,
            maxLines: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${book.author}',
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
            color: theme.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
          onTap(book);
        }
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress(book);
        }
      },
    );
  }
}

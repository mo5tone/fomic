import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fomic/model/entity/book.dart';

class BookWidget extends StatelessWidget {
  final radius = 10.0;
  final Book book;
  final void Function() onTap;

  const BookWidget(this.book, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius),
                  bottom: Radius.zero,
                ),
                child: CachedNetworkImage(
                  imageUrl: book.thumbnail.uri.toString(),
                  fit: BoxFit.cover,
                  httpHeaders: book.thumbnail.headers.map((key, value) => MapEntry(key, '$value')),
                  errorWidget: (context, url, error) => Icon(Icons.broken_image),
                ),
              ),
            ),
            Text(
              book.title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onTap: onTap ?? () => log('Tap on ${book.title}'),
      ),
    );
  }
}

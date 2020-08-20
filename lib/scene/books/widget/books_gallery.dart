import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';

class BooksGallery extends StatelessWidget {
  final List<Book> books;
  final void Function(ScrollNotification notification) onScroll;
  final void Function(BuildContext context, Book book) didTapOn;

  const BooksGallery(this.books, {Key key, this.onScroll, this.didTapOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        onScroll(notification);
        return false;
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (ctx, idx) => _Cell(
                books[idx],
                onTap: () => didTapOn(ctx, books[idx]),
              ),
              childCount: books.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final radius = 10.0;
  final Book book;
  final void Function() onTap;

  const _Cell(this.book, {Key key, this.onTap}) : super(key: key);

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

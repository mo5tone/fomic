import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';

class BooksGallery extends StatelessWidget {
  final List<Book> books;
  final ScrollController scrollController;
  final void Function(BuildContext context, Book book) didTapOn;

  const BooksGallery(this.books, {Key key, this.scrollController, this.didTapOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeDisplayed = MediaQuery.of(context).size;
    final childAspectRatio = sizeDisplayed.width / sizeDisplayed.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              _cellBuilder,
              childCount: books.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: childAspectRatio,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellBuilder(BuildContext context, int index) {
    final book = books[index];
    final radius = 8.0;
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
              flex: 23,
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
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  book.title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        ),
        onTap: () => didTapOn(context, book),
      ),
    );
  }
}

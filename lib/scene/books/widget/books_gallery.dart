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
    final space = 8.0;
    // final childAspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Container(
      margin: EdgeInsets.all(space),
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
              mainAxisSpacing: space,
              crossAxisSpacing: space,
              childAspectRatio: 3 / 4,
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).backgroundColor.withOpacity(0.5),
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
              flex: 3,
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
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  book.title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.subtitle1,
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

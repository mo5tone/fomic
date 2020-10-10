import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/utils/extended_image_state.dart';

class BooksGallery extends StatelessWidget {
  final List<Book> books;
  final ScrollController scrollController;
  final void Function(BuildContext context, Book book) didTapOn;

  const BooksGallery(
    this.books, {
    Key key,
    this.scrollController,
    this.didTapOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final space = 8.0;
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
              crossAxisCount: 2,
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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: theme.backgroundColor.withOpacity(0.5),
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius),
                  bottom: Radius.zero,
                ),
                child: ExtendedImage.network(
                  book.thumbnail.uri.toString(),
                  fit: BoxFit.cover,
                  headers: book.thumbnail.headers.map((key, value) => MapEntry(key, '$value')),
                  loadStateChanged: (state) => state.loadStateWidget(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 4),
                child: Stack(
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.headline6,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            bottomRight: Radius.circular(radius),
                          ),
                        ),
                        child: Text(
                          '${book.status.description}',
                          style: theme.textTheme.subtitle1.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
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

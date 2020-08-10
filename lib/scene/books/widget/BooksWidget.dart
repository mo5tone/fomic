import 'package:flutter/material.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/scene/books/widget/BookWidget.dart';

class BooksWidget extends StatelessWidget {
  final List<Book> books;
  final void Function(ScrollNotification notification) onScroll;
  final void Function(Book book) didTapOn;

  const BooksWidget(this.books, {Key key, this.onScroll, this.didTapOn}) : super(key: key);

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
              (ctx, idx) => BookWidget(
                books[idx],
                onTap: () => didTapOn(books[idx]),
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

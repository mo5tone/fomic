import 'package:flutter/widgets.dart';
import 'package:fomic/model/entity/Book.dart';

class BookWidget extends StatelessWidget {
  final Book book;

  const BookWidget({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(book.title),
    );
  }
}

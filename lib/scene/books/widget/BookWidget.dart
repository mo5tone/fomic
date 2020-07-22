import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fomic/model/entity/Book.dart';

class BookWidget extends StatelessWidget {
  final Book book;

  const BookWidget({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: CachedNetworkImage(
              imageUrl: book.thumbnail.uri.toString(),
              fit: BoxFit.cover,
              httpHeaders: book.thumbnail.headers.map((key, value) => MapEntry(key, '$value')),
              errorWidget: (context, url, error) => Icon(Icons.broken_image),
            ),
          ),
          Text(
            book.title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

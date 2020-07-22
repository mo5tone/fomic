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
          CachedNetworkImage(
            imageUrl: book.thumbnailRequest.url,
            fit: BoxFit.cover,
            httpHeaders: book.thumbnailRequest.headers,
            errorWidget: (context, url, error) => Icon(Icons.broken_image),
          ),
          Text(book.title),
        ],
      ),
    );
  }
}

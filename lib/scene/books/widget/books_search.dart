import 'package:flutter/material.dart';
import 'package:fomic/model/constant/app.i18n.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/source/source.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';

class BooksSearch extends SearchDelegate {
  final Source source;
  final _scrollController = ScrollController();

  var _loading = false;
  var _page = 0;
  var _keyword = '';
  var _books = <Book>[];

  BooksSearch(this.source, {String hint}) : super(searchFieldLabel: hint ?? 'Keyword'.i18n) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        final position = _scrollController.position;
        if (position.pixels > position.maxScrollExtent + 30) _search(query);
      });
    });
  }

  Future<List<Book>> _search(String keyword) {
    if (keyword == null || keyword.isEmpty || _loading) return Future.value([]);
    _loading = true;
    if (_keyword != keyword) {
      _page = 0;
      _books = [];
    }
    return source.fetchBooks(page: _page, query: keyword).then((value) {
      _page += 1;
      _keyword = keyword;
      _books += value;
      return _books;
    }).catchError((err) {
      _page = 0;
      _keyword = '';
      _books = [];
      return _books;
    }).whenComplete(() {
      _loading = false;
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        query = '';
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _search(query),
      initialData: <Book>[],
      builder: (ctx, snapshot) => BooksGallery(
        snapshot.data,
        scrollController: _scrollController,
        didTapOn: close,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

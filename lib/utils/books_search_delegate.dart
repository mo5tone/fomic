import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/repository/repository.dart';
import 'package:fomic/scene/books/widget/books_widget.dart';

class BooksSearchDelegate extends SearchDelegate {
  final Repository source;
  final void Function(BuildContext context, Book book) didTapOn;

  var _loading = false;
  var _page = 0;
  var _keyword = '';
  var _books = <Book>[];

  BooksSearchDelegate(this.source, {this.didTapOn, String hint}) : super(searchFieldLabel: hint);

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

  void _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics.pixels == metrics.maxScrollExtent) {
      _search(query);
    }
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
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
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
      builder: (ctx, snapshot) => BooksWidget(
        snapshot.data,
        onScroll: _onScroll,
        didTapOn: (value) => didTapOn(context, value),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

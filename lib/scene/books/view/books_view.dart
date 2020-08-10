import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/viewmodel/books_view_model.dart';
import 'package:fomic/scene/books/widget/books_widget.dart';
import 'package:fomic/utils/books_search_delegate.dart';
import 'package:fomic/utils/widget/listenable_preferred_size_widget.dart';
import 'package:provider/provider.dart';

class BooksView extends StatefulWidget {
  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  BooksViewModel viewmodel;

  void _didTapOn(BuildContext context, Book book) {
    log('didTapOn ${book.title}');
  }

  void _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics.pixels == metrics.maxScrollExtent) {
      viewmodel.load();
    }
  }

  @override
  void initState() {
    super.initState();
    viewmodel = Provider.of<BooksViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ListenablePreferredSizeWidget<BooksViewModel>(
        child: AppBar(
          title: Text(viewmodel.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: BooksSearchDelegate(
                  viewmodel.repository,
                  didTapOn: _didTapOn,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Selector<BooksViewModel, List<Book>>(
        selector: (ctx, viewmodel) => viewmodel.books,
        builder: (ctx, books, child) => RefreshIndicator(
          child: BooksWidget(
            books,
            onScroll: _onScroll,
            didTapOn: (book) => _didTapOn(ctx, book),
          ),
          onRefresh: () => viewmodel.refresh(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () => viewmodel.favorite(),
      ),
    );
  }
}

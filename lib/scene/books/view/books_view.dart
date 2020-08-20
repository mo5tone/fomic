import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/viewmodel/books_view_model.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/utils/books_search_delegate.dart';
import 'package:provider/provider.dart';

class BooksView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<BooksViewModel, BooksView> {
  void _didTapOn(BuildContext context, Book book) {
    log('didTapOn ${book.title}');
  }

  void _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics.pixels == metrics.maxScrollExtent) {
      vm.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: BooksSearchDelegate(
                vm.repository,
                didTapOn: _didTapOn,
              ),
            ),
          ),
        ],
      ),
      body: Selector<BooksViewModel, List<Book>>(
        selector: (ctx, value) => value.books,
        builder: (ctx, value, child) {
          return RefreshIndicator(
            child: BooksGallery(
              value,
              onScroll: _onScroll,
              didTapOn: _didTapOn,
            ),
            onRefresh: () => vm.refresh(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () => vm.favorite(),
      ),
    );
  }
}

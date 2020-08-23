import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/viewmodel/books_view_model.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/scene/books/widget/books_search.dart';
import 'package:provider/provider.dart';

class BooksView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<BooksViewModel, BooksView> {
  final _scrollController = ScrollController();

  void _didTapOn(BuildContext context, Book book) {
    // TODO: - Navigate to book detail
    log('didTapOn ${book.title}');
  }

  void _didScroll() {
    final minOffset = 30.0;
    final position = _scrollController.position;
    vm.scrollToTop = position.pixels > position.minScrollExtent + minOffset;
    if (position.pixels > position.maxScrollExtent + minOffset) vm.load();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_didScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: BooksSearch(vm.repository))
                .then((value) => _didTapOn(context, value))
                .catchError((err) => null),
          ),
        ],
      ),
      body: Selector<BooksViewModel, List<Book>>(
        selector: (ctx, value) => value.books,
        builder: (ctx, value, child) {
          return RefreshIndicator(
            child: BooksGallery(
              value,
              scrollController: _scrollController,
              didTapOn: _didTapOn,
            ),
            onRefresh: () => vm.refresh(),
          );
        },
      ),
      floatingActionButton: Selector<BooksViewModel, bool>(
        selector: (ctx, value) => value.scrollToTop,
        builder: (ctx, value, child) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value)
              FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () =>
                    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease),
              ),
          ],
        ),
      ),
    );
  }
}

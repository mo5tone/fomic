import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/viewmodel/books_view_model.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:fomic/scene/common/view_model/bottom_navigation_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/scene/books/widget/books_search.dart';
import 'package:provider/provider.dart';

class BooksView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<BooksViewModel, BooksView> with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  void _didTapOn(BuildContext context, Book book) {
    // TODO: navigate to book detail
    log('didTapOn ${book.title}');
  }

  void _didScroll() {
    final minOffset = 30.0;
    final position = _scrollController.position;
    if (position.pixels > position.maxScrollExtent + minOffset) vm.load();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_didScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bottomNavigationViewModel = context.watch<BottomNavigationViewModel>();
    if (bottomNavigationViewModel.reTappedIndex == 0) {
      _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
      bottomNavigationViewModel.reTappedIndex = null;
    }
    final books = context.select((BooksViewModel value) => value.books);
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: BooksSearch(vm.source))
                .then((value) => _didTapOn(context, value))
                .catchError((err) => null),
          ),
        ],
      ),
      body: RefreshIndicator(
        child: BooksGallery(
          books,
          scrollController: _scrollController,
          didTapOn: _didTapOn,
        ),
        onRefresh: () => vm.refresh(),
      ),
    );
  }
}

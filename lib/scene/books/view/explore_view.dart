import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/viewmodel/explore_view_model.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:fomic/scene/common/view_model/tab_navigation_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/scene/books/widget/explore_searcher.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<ExploreViewModel, ExploreView> with AutomaticKeepAliveClientMixin {
  final minOffset = 30.0;
  final scrollController = ScrollController();

  ScrollPosition get scrollPosition => scrollController.position;

  void didTapOn(BuildContext context, Book book) {
    // TODO: navigate to book detail
    log('didTapOn ${book.title}');
  }

  void didScroll() {
    final position = scrollController.position;
    if (position.pixels > position.maxScrollExtent + minOffset) vm.load();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(didScroll);
      final bottomNavigationViewModel = context.read<TabNavigationViewModel>();
      bottomNavigationViewModel.addReTappedIndexListener(() {
        final position = scrollController.position;
        if (bottomNavigationViewModel.reTappedIndex == 0 && position.pixels > position.minScrollExtent + minOffset) {
          scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
        }
        bottomNavigationViewModel.reTappedIndex = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: ExploreSearcher(vm.source))
                .then((value) => didTapOn(context, value))
                .catchError((err) => null),
          ),
        ],
      ),
      body: Selector<ExploreViewModel, List<Book>>(
        selector: (ctx, value) => value.books,
        builder: (ctx, books, child) {
          return RefreshIndicator(
            child: BooksGallery(
              books,
              scrollController: scrollController,
              didTapOn: didTapOn,
            ),
            onRefresh: () => vm.refresh(),
          );
        },
      ),
    );
  }
}

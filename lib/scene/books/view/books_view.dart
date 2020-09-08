import 'package:flutter/material.dart';
import 'package:fomic/model/constant/routing.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/view_model/books_view_model.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:fomic/scene/common/view_model/tab_navigation_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/scene/books/widget/books_searcher.dart';
import 'package:provider/provider.dart';

class BooksView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<BooksViewModel, BooksView> with AutomaticKeepAliveClientMixin {
  final _minOffset = 30.0;
  final _scrollController = ScrollController();

  ScrollPosition get scrollPosition => _scrollController.position;

  void _didTapOn(BuildContext context, Book book) {
    Routing.chapters.push(
      context,
      arguments: {
        'source': vm.source,
        'book': book,
      },
    );
  }

  void _didScroll() {
    final position = _scrollController.position;
    if (position.pixels > position.maxScrollExtent + _minOffset) vm.load();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_didScroll);
      final bottomNavigationViewModel = context.read<TabNavigationViewModel>();
      bottomNavigationViewModel.addReTappedIndexListener(() {
        final position = _scrollController.position;
        if (bottomNavigationViewModel.reTappedIndex == 0 && position.pixels > position.minScrollExtent + _minOffset) {
          _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
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
            onPressed: () => showSearch(context: context, delegate: BooksSearcher(vm.source))
                .then((value) => _didTapOn(context, value))
                .catchError((err) => null),
          ),
        ],
      ),
      body: Selector<BooksViewModel, List<Book>>(
        selector: (ctx, value) => value.books,
        builder: (ctx, books, child) {
          return RefreshIndicator(
            child: BooksGallery(
              books,
              scrollController: _scrollController,
              didTapOn: _didTapOn,
            ),
            onRefresh: () => vm.refresh(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/constant/source_id.dart';
import 'package:fomic/common/constant/routing.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/scene/books/notifier.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:fomic/scene/books/widget/books_search/delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BooksScreen extends HookWidget {
  void _didTap(BuildContext context, Book book) {
    Routing.chapters.push(context, arguments: {'book': book});
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.extentAfter == 10) {
          context.read(rpBooksStateNotifier).load();
        }
      });
      return null;
    }, [scrollController]);
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, watch, child) {
            return Text(watch(rpSourceId).state.name);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BooksSearchDelegate()).then((value) => _didTap(context, value)).catchError((err) => null);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: Consumer(
          builder: (context, watch, child) => BooksGallery(
            books: watch(rpBooksStateNotifier.state).books,
            scrollController: scrollController,
            didTap: _didTap,
          ),
        ),
        onRefresh: () => context.read(rpBooksStateNotifier).refresh(),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/notifier/hud_state_notifier.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/source.dart';
import 'package:fomic/scene/books/widget/books_gallery.dart';
import 'package:hooks_riverpod/all.dart';

part 'notifier.dart';

class BooksSearchDelegate extends SearchDelegate<Book> {
  BooksSearchDelegate({String hint}) : super(searchFieldLabel: hint ?? 'Keyword');

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
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
      icon: Icon(TargetPlatform.android == Theme.of(context).platform ? Icons.arrow_back : Icons.arrow_back_ios),
      onPressed: () {
        query = '';
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read(rpBooksSearchStateNotifier).search(query);
    return _SearchResults(
      query: query,
      didTap: close,
      loadMore: () => context.read(rpBooksSearchStateNotifier).search(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class _SearchResults extends HookWidget {
  final String query;
  final void Function(BuildContext context, Book book) didTap;
  final void Function() loadMore;

  _SearchResults({
    Key key,
    @required this.query,
    this.didTap,
    this.loadMore,
  })  : assert(query?.isNotEmpty ?? false),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.extentAfter == 10 && loadMore != null) loadMore();
      });
      return null;
    }, [scrollController]);
    final books = useProvider(rpBooksSearchStateNotifier.state).books;
    return BooksGallery(
      books: books,
      scrollController: scrollController,
      didTap: didTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/scene/books/widget/BookWidget.dart';
import 'package:fomic/scene/books/viewmodel/BooksSearchViewModel.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class BooksSearchView extends SearchDelegate<String> {
  final BooksSearchViewModel _viewmodel;

  BooksSearchView(SourceId sourceId, {String hint})
      : _viewmodel = GetIt.I.get<BooksSearchViewModel>(param1: sourceId),
        super(searchFieldLabel: hint);

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
        onPressed: () {
          query = '';
        },
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
    _viewmodel.search(query);
    final scrollController = ScrollController();
    scrollController.addListener(() {
      final position = scrollController.position;
      if (position.pixels == position.maxScrollExtent) {
        _viewmodel.search(query);
      }
    });
    return ChangeNotifierProvider.value(
      value: _viewmodel,
      builder: (ctx, child) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Selector<BooksSearchViewModel, List<Book>>(
            selector: (ctx, value) => value.books,
            builder: (ctx, value, child) => CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, idx) => BookWidget(
                      book: value[idx],
                    ),
                    childCount: value.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

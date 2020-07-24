import 'package:flutter/material.dart';
import 'package:fomic/model/constant/SourceId.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/scene/books/widget/BookWidget.dart';
import 'package:fomic/scene/books/viewmodel/BooksViewModel.dart';
import 'package:fomic/scene/books/view/BooksSearchView.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class BooksView extends StatelessWidget {
  final SourceId sourceId;

  const BooksView({Key key, this.sourceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = GetIt.I.get<BooksViewModel>(param1: sourceId);
    viewmodel.refresh();
    final scrollController = ScrollController();
    scrollController.addListener(() {
      final position = scrollController.position;
      if (position.pixels == position.maxScrollExtent) {
        viewmodel.load();
      }
    });
    return ChangeNotifierProvider.value(
      value: viewmodel,
      builder: (ctx, child) => Scaffold(
        appBar: AppBar(
          title: Text(sourceId.name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: ctx,
                delegate: BooksSearchView(sourceId),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Selector<BooksViewModel, List<Book>>(
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
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onRefresh: () => viewmodel.refresh(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () => null,
        ),
      ),
    );
  }
}

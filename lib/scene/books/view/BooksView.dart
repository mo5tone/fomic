import 'package:flutter/material.dart';
import 'package:fomic/model/constant/SourceID.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/scene/books/widget/BookWidget.dart';
import 'package:fomic/scene/books/viewmodel/BooksViewModel.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class BooksView extends StatelessWidget {
  final SourceID sourceID;

  const BooksView({Key key, this.sourceID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = GetIt.I.get<BooksViewModel>(param1: sourceID);
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
          title: Text(sourceID.name),
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
                        ),
                      ),
                    ],
                  ),
                ),
                Selector<BooksViewModel, bool>(
                  selector: (ctx, value) => value.loading,
                  builder: (ctx, value, child) => Container(
                    child: value ? CircularProgressIndicator() : null,
                    margin: EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
            onRefresh: () => viewmodel.refresh()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () => null,
        ),
      ),
    );
  }
}
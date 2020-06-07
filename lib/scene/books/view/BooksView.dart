import 'package:flutter/material.dart';
import 'package:fomic/model/constant/SourceName.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/scene/books/view/BookWidget.dart';
import 'package:fomic/scene/books/viewmodel/BooksViewModel.dart';
import 'package:provider/provider.dart';

class BooksView extends StatelessWidget {
  final SourceName sourceName;

  const BooksView({Key key, this.sourceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = BooksViewModel(sourceName);
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
          title: Text(sourceName.title),
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
                          crossAxisCount: 3,
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

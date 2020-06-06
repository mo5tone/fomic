import 'package:flutter/material.dart';
import 'package:fomic/model/constant/SourceName.dart';
import 'package:fomic/model/entity/Book.dart';
import 'package:fomic/scene/books/viewmodel/BooksViewModel.dart';
import 'package:provider/provider.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewmodel = BooksViewModel(SourceName.dmzj);
    _viewmodel.refresh();
    return Scaffold(
      appBar: AppBar(
        title: Text(SourceName.dmzj.title),
      ),
      body: ChangeNotifierProvider.value(
        value: _viewmodel,
        builder: (ctx, child) => Selector<BooksViewModel, bool>(
          selector: (ctx, value) => value.loading,
          builder: (ctx, value, child) => value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    Selector<BooksViewModel, List<Book>>(
                      selector: (ctx, value) => value.books,
                      builder: (ctx, value, child) => SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, idx) => Text(value[idx].title),
                          childCount: value.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _viewmodel.load(),
      ),
    );
  }
}

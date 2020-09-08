import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/entity/chapter.dart';
import 'package:fomic/scene/chapters/view_model/chapters_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:provider/provider.dart';

class ChaptersView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<ChaptersViewModel, ChaptersView> {
  final _tabs = ['Introduction', 'Chapters'];

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final expandedHeight = mediaQueryData.size.height / 4;
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, isScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: Selector<ChaptersViewModel, Book>(
                selector: (_, value) => value.book,
                builder: (_, book, __) => SliverAppBar(
                  title: Text('${book.title}'),
                  forceElevated: isScrolled,
                  pinned: true,
                  expandedHeight: expandedHeight,
                  stretch: true,
                  actions: [
                    // IconButton(
                    //   icon: Icon(Icons.swap_vert),
                    //   onPressed: () {
                    //     final maxScrollExtent = _scrollController.position.maxScrollExtent;
                    //     final minScrollExtent = _scrollController.position.minScrollExtent;
                    //     final pixels = _scrollController.position.pixels;
                    //     _scrollController.animateTo(
                    //       pixels - minScrollExtent > maxScrollExtent - pixels ? minScrollExtent : maxScrollExtent,
                    //       duration: Duration(
                    //         milliseconds: 300,
                    //       ),
                    //       curve: Curves.easeInOut,
                    //     );
                    //   },
                    // ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: book.thumbnail.uri.toString(),
                      fit: BoxFit.cover,
                      httpHeaders: book.thumbnail.headers.map((key, value) => MapEntry(key, '$value')),
                      errorWidget: (ctx, url, error) => Icon(Icons.broken_image),
                    ),
                  ),
                  bottom: TabBar(
                    tabs: _tabs.map((name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              Selector<ChaptersViewModel, Book>(
                key: PageStorageKey(_tabs[0]),
                selector: (_, value) => value.book,
                builder: (_, book, __) => Center(
                  child: Text('${book.description}'),
                ),
              ),
              Selector<ChaptersViewModel, List<Chapter>>(
                key: PageStorageKey(_tabs[1]),
                selector: (_, value) => value.chapters,
                builder: (ctx, chapters, __) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 48,
                        delegate: SliverChildBuilderDelegate(
                          (_, idx) {
                            final chapter = chapters[idx];
                            final formatter = DateFormat('yyyy/MM/dd HH:mm:ss');
                            final updatedAt = DateTime.fromMillisecondsSinceEpoch(chapter.updatedAt);
                            return ListTile(
                              title: Text('${chapter.name}'),
                              subtitle: chapter.updatedAt > 0 ? Text('${formatter.format(updatedAt)}') : null,
                            );
                          },
                          childCount: chapters.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          // TODO:
        },
      ),
    );
  }
}

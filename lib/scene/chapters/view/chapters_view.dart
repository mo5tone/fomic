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

  void _read(Chapter chapter) {
    // TODO:
  }

  void _favorite() {
    // TODO:
  }

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
                builder: (ctx, book, __) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    ),
                    SliverToBoxAdapter(
                      child: AspectRatio(
                        aspectRatio: mediaQueryData.size.aspectRatio * 2,
                        child: Card(
                          elevation: 16.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    child: CachedNetworkImage(
                                      imageUrl: book.thumbnail.uri.toString(),
                                      fit: BoxFit.cover,
                                      httpHeaders: book.thumbnail.headers.map((key, value) => MapEntry(key, '$value')),
                                      errorWidget: (context, url, error) => Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              '${book.description}',
                                            ),
                                          ),
                                        ),
                                        if ((book.genre ?? '').isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              Text('Genre: '),
                                              Text('${book.genre}'),
                                            ],
                                          ),
                                        if ((book.author ?? '').isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              Text('Author: '),
                                              Text('${book.author}'),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                              onTap: () => _read(chapter),
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
        onPressed: _favorite,
      ),
    );
  }
}

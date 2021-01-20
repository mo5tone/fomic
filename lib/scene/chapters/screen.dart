import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/extension/extended_image_state_x.dart';
import 'package:fomic/notifier/hud_state_notifier.dart';
import 'package:fomic/source/source.dart';
import 'package:fomic/storage/favorite.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/model/chapter.dart';

part './notifier.dart';

class ChaptersScreen extends HookWidget {
  final Book book;
  final StateNotifierProvider<ChaptersStateNotifier> stateNotifierProvider;

  final _tabs = [
    Tab(
      icon: Icon(Icons.info),
    ),
    Tab(
      icon: Icon(Icons.list),
    ),
  ];

  void _read(BuildContext context, Chapter chapter) {
    // final arguments = {
    //   'source': vm.source,
    //   'book': vm.book,
    //   'chapter': chapter,
    // };
    // Routing.pages.push(context, arguments: arguments);
  }

  ChaptersScreen({Key key, @required this.book})
      : stateNotifierProvider = rpChaptersStateNotifier(book),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final expandedHeight = mediaQueryData.size.height / 4;
    useEffect(() {
      context.read(stateNotifierProvider).fetch();
      return null;
    });
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, isScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: Consumer(
                builder: (context, watch, child) {
                  final book = watch(stateNotifierProvider.state).book;
                  return SliverAppBar(
                    title: Text('${book.title}'),
                    forceElevated: isScrolled,
                    pinned: true,
                    expandedHeight: expandedHeight,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ExtendedImage.network(
                        book.thumbnailUrl,
                        fit: BoxFit.cover,
                        headers: book.thumbnailHeaders.map((key, value) => MapEntry(key, '$value')),
                        loadStateChanged: (state) => state.loadStateWidget(),
                      ),
                    ),
                    bottom: TabBar(
                      tabs: _tabs,
                    ),
                  );
                },
              ),
            ),
          ],
          body: TabBarView(
            children: [
              Consumer(
                key: PageStorageKey(0),
                builder: (context, watch, child) {
                  final book = watch(stateNotifierProvider.state).book;
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                                      child: ExtendedImage.network(
                                        book.thumbnailUrl,
                                        fit: BoxFit.cover,
                                        headers: book.thumbnailHeaders.map((key, value) => MapEntry(key, '$value')),
                                        loadStateChanged: (state) => state.loadStateWidget(),
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
                                              child: Text('${book.description ?? ''}'),
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
                  );
                },
              ),
              Consumer(
                key: PageStorageKey(1),
                builder: (context, watch, child) {
                  final chapters = watch(stateNotifierProvider.state).chapters;
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                                title: Text('${chapter.name ?? idx}'),
                                subtitle: chapter.updatedAt > 0 ? Text('${formatter.format(updatedAt)}') : null,
                                onTap: () => _read(context, chapter),
                              );
                            },
                            childCount: chapters.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Consumer(
          builder: (context, watch, child) {
            final favorited = watch(stateNotifierProvider.state).favorited;
            return Icon(favorited ? Icons.favorite : Icons.favorite_border);
          },
        ),
        onPressed: () => context.read(stateNotifierProvider).toggleFavorite(),
      ),
    );
  }
}

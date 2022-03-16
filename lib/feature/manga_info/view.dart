import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/feature/manga_info/bloc.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:fomic/repository/source/source.dart';
import 'package:intl/intl.dart';

class MangaInfoView extends HookConsumerWidget {
  final MangaInfo _manga;

  const MangaInfoView({Key? key, required MangaInfo manga})
      : _manga = manga,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = MangaInfoBLoC.family(_manga);
    final mediaQueryData = MediaQuery.of(context);
    final expandedHeight = mediaQueryData.size.height / 4;
    useEffect(() {
      ref.read(provider.notifier).add(const MangaInfoEvent.refresh());
      return null;
    });
    final currentTabIndex = StateProvider((_) => 0);
    const tabs = [Tab(icon: Icon(Icons.info)), Tab(icon: Icon(Icons.list))];
    final tabController = useTabController(initialLength: tabs.length);
    tabController.addListener(() {
      ref.read(currentTabIndex.notifier).state = tabController.index;
    });
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: Consumer(
              builder: (context, ref, child) {
                final manga = ref.watch(provider.select((value) => value.manga));
                return SliverAppBar(
                  title: Text(manga.title),
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  expandedHeight: expandedHeight,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: manga.cover,
                      httpHeaders: (ref.watch(Source.provider) as HttpSource).headers,
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: TabBar(
                    tabs: tabs,
                    controller: tabController,
                  ),
                );
              },
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            Builder(builder: (context) {
              return CustomScrollView(
                key: const PageStorageKey(0),
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  SliverToBoxAdapter(
                    child: AspectRatio(
                      aspectRatio: mediaQueryData.size.aspectRatio * 2,
                      child: Card(
                        elevation: 16.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final manga = ref.watch(provider.select((value) => value.manga));
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      child: CachedNetworkImage(
                                        imageUrl: manga.cover,
                                        httpHeaders: (ref.watch(Source.provider) as HttpSource).headers,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Text(manga.description),
                                            ),
                                          ),
                                          if (manga.genres.isNotEmpty)
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                const Text('Genre: '),
                                                Text(manga.genres.join(', ')),
                                              ],
                                            ),
                                          if (manga.author.isNotEmpty)
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                const Text('Author: '),
                                                Text(
                                                  manga.author,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Consumer(
              builder: (context, ref, child) {
                final chapters = ref.watch(provider.select((value) => value.chapters));
                return CustomScrollView(
                  key: const PageStorageKey(1),
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
                            final formatter = DateFormat('yyyy/MM/dd');
                            final updatedAt = DateTime.fromMillisecondsSinceEpoch(chapter.dateUpload);
                            return ListTile(
                              title: Text(chapter.name),
                              subtitle: chapter.dateUpload > 0 ? Text(formatter.format(updatedAt)) : null,
                              onTap: () {},
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
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(currentTabIndex);
          // TODO: implement
          final isFavorite = false;
          return FloatingActionButton(
            child: Icon(index == 0
                ? isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border
                : Icons.play_arrow),
            onPressed: () {
              if (index == 0) {
                ref.read(provider.notifier).add(const MangaInfoEvent.favorite());
              } else {
                ref.read(provider.notifier).add(const MangaInfoEvent.favorite());
              }
            },
          );
        },
      ),
    );
  }
}

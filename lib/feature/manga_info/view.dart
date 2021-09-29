import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/feature/manga_info/bloc.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:fomic/repository/source/source.dart';
import 'package:intl/intl.dart';

class MangaInfoView extends HookConsumerWidget {
  final AutoDisposeStateNotifierProvider<MangaInfoBLoC, MangaInfoState> provider;

  MangaInfoView({Key? key, required MangaInfo manga})
      : provider = MangaInfoBLoC.family(manga),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQueryData = MediaQuery.of(context);
    final expandedHeight = mediaQueryData.size.height / 4;
    useEffect(() {
      ref.read(provider.notifier).add(const MangaInfoEvent.refresh());
    });
    const _tabs = [Tab(icon: Icon(Icons.info)), Tab(icon: Icon(Icons.list))];
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: Consumer(
                builder: (context, ref, child) {
                  final manga = ref.watch(provider.select((value) => value.manga));
                  return SliverAppBar(
                    title: Text(manga.title),
                    forceElevated: isScrolled,
                    pinned: true,
                    expandedHeight: expandedHeight,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ExtendedImage.network(
                        manga.cover,
                        fit: BoxFit.cover,
                        headers: (ref.watch(Source.provider) as HttpSource).headers,
                      ),
                    ),
                    bottom: const TabBar(
                      tabs: _tabs,
                    ),
                  );
                },
              ),
            ),
          ],
          body: TabBarView(
            children: [
              CustomScrollView(
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
                                      child: ExtendedImage.network(
                                        manga.cover,
                                        fit: BoxFit.cover,
                                        headers: (ref.watch(Source.provider) as HttpSource).headers,
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
                                                Text(manga.author),
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
              ),
              Consumer(
                key: const PageStorageKey(1),
                builder: (context, ref, child) {
                  final chapters = ref.watch(provider.select((value) => value.chapters));
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Consumer(
          builder: (context, ref, child) {
            final isFavorite = false;
            return Icon(isFavorite ? Icons.favorite : Icons.favorite_border);
          },
        ),
        onPressed: () => ref.read(provider.notifier).add(const MangaInfoEvent.favorite()),
      ),
    );
  }
}

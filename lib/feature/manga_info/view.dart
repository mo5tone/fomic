import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/route/screen.dart';
import 'package:fomic/common/widget/marquee.dart';
import 'package:fomic/feature/manga_info/bloc.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MangaInfoView extends HookConsumerWidget {
  final MangaInfo manga;

  const MangaInfoView({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = MangaInfoBLoC.family(manga);
    final bloc = ref.read(provider.notifier);
    useEffect(() {
      bloc.add(const MangaInfoEvent.refresh());
      return null;
    });
    return Scaffold(
      body: RefreshIndicator(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            _AppBar(provider: provider),
            _ChapterInfoList(provider: provider),
          ],
        ),
        onRefresh: () => Future(() => bloc.add(const MangaInfoEvent.refresh())),
      ),
    );
  }
}

class _AppBar extends HookConsumerWidget {
  final AutoDisposeStateNotifierProvider<MangaInfoBLoC, MangaInfoState> provider;

  const _AppBar({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQueryData = MediaQuery.of(context);
    final expandedHeight = mediaQueryData.size.height / 3;
    final manga = ref.watch(provider.select((value) => value.manga));
    final theme = Theme.of(context);
    return SliverAppBar(
      title: InkWell(
        child: Marquee(
          child: Text(
            manga.title,
          ),
        ),
        onLongPress: () async {
          await Clipboard.setData(ClipboardData(text: manga.title));
          final snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.copiedToClipboard));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
      pinned: true,
      forceElevated: true,
      expandedHeight: expandedHeight,
      stretch: false,
      flexibleSpace: FlexibleSpaceBar(
        background: _AppBarFlexibleSpaceBackground(manga: manga),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                ref.read(provider.notifier).add(const MangaInfoEvent.swapList());
              },
              color: theme.colorScheme.onPrimary,
              icon: const Icon(Icons.swap_vert),
            ),
            IconButton(
              onPressed: () {},
              color: theme.colorScheme.onPrimary,
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () {},
              color: theme.colorScheme.onPrimary,
              icon: const Icon(Icons.open_in_browser),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarFlexibleSpaceBackground extends HookConsumerWidget {
  final MangaInfo manga;

  const _AppBarFlexibleSpaceBackground({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const radius = 8.0;
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: manga.cover,
          httpHeaders: ref.read(HTTPSource.provider).headers,
          fit: BoxFit.cover,
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          colorBlendMode: BlendMode.modulate,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                theme.colorScheme.primary.withOpacity(0),
                theme.colorScheme.primary,
              ],
              stops: const [
                0,
                1,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight,
              horizontal: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: manga.key,
                  child: Card(
                    elevation: radius,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: CachedNetworkImage(
                        imageUrl: manga.cover,
                        httpHeaders: ref.read(HTTPSource.provider).headers,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (manga.description.isNotEmpty)
                        Expanded(
                          child: Text(
                            manga.description,
                            overflow: TextOverflow.fade,
                            maxLines: 100,
                            style: theme.textTheme.bodySmall?.apply(color: theme.colorScheme.onPrimary),
                          ),
                        ),
                      if (manga.author.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            manga.author,
                            style: theme.textTheme.bodyText1?.apply(color: theme.colorScheme.onPrimary),
                          ),
                        ),
                      if (manga.artist.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.only(
                            top: 2,
                          ),
                          child: Text(
                            manga.artist,
                            style: theme.textTheme.bodyText1?.apply(color: theme.colorScheme.onPrimary),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 4,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: theme.textTheme.bodyText1?.height,
                              child: manga.status.image(
                                color: theme.colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              manga.status.name.toUpperCase(),
                              style: theme.textTheme.bodyText1?.apply(color: theme.colorScheme.onPrimary),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '#',
                              style: theme.textTheme.bodyText1?.apply(color: theme.colorScheme.onPrimary),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              ref.read(HTTPSource.provider).name,
                              style: theme.textTheme.bodyText1?.apply(color: theme.colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChapterInfoList extends HookConsumerWidget {
  final AutoDisposeStateNotifierProvider<MangaInfoBLoC, MangaInfoState> provider;

  const _ChapterInfoList({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapters = ref.watch(provider.select((value) => value.chapters));
    return SliverPadding(
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
              onTap: () => Screen.chapterInfo(chapter).push(context),
            );
          },
          childCount: chapters.length,
        ),
      ),
    );
  }
}

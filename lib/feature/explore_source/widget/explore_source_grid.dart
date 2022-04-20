import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';

class ExploreSourceGrid extends HookConsumerWidget {
  final List<MangaInfo> mangas;
  final ScrollController? scrollController;
  final void Function(BuildContext context, MangaInfo manga)? didTap;

  const ExploreSourceGrid({
    Key? key,
    required this.mangas,
    this.scrollController,
    this.didTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const space = 8.0;
    return Container(
      margin: const EdgeInsets.all(space),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _Cell(
                manga: mangas[index],
                didTap: (context, manga) {
                  if (didTap != null) didTap!(context, manga);
                },
              ),
              childCount: mangas.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: space,
              crossAxisSpacing: space,
              childAspectRatio: 3 / 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _Cell extends HookConsumerWidget {
  final MangaInfo manga;
  final void Function(BuildContext context, MangaInfo manga)? didTap;

  const _Cell({
    Key? key,
    required this.manga,
    this.didTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const radius = 8.0;
    final theme = Theme.of(context);
    return Hero(
      tag: manga.key,
      child: Card(
        elevation: radius,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: manga.cover,
                httpHeaders: ref.read(HttpSource.provider).headers,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(radius),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color.fromARGB(0x00, 0xff, 0xff, 0xff),
                      Color.fromARGB(0xaa, 0x00, 0x00, 0x00),
                    ],
                    stops: [
                      0,
                      0.8,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: radius,
                bottom: radius,
                right: radius,
                child: Text(
                  manga.title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleMedium?.apply(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            if (didTap != null) didTap!(context, manga);
          },
        ),
      ),
    );
  }
}

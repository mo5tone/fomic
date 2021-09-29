import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:fomic/repository/source/source.dart';

class MangasGrid extends HookConsumerWidget {
  final List<MangaInfo> mangas;
  final ScrollController? scrollController;
  final void Function(BuildContext context, MangaInfo manga)? didTap;

  const MangasGrid({
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
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: theme.backgroundColor.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(radius),
                  bottom: Radius.zero,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ExtendedImage.network(
                      manga.cover,
                      fit: BoxFit.cover,
                      headers: (ref.watch(Source.provider) as HttpSource).headers,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                child: Stack(
                  children: [
                    Text(
                      manga.title,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.headline6,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            bottomRight: Radius.circular(radius),
                          ),
                        ),
                        child: Text(
                          '${manga.status}',
                          style: theme.textTheme.subtitle1?.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          if (didTap != null) didTap!(context, manga);
        },
      ),
    );
  }
}

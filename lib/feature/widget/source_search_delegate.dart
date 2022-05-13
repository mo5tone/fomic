import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/route/screen.dart';
import 'package:fomic/feature/explore_source/bloc.dart';
import 'package:fomic/feature/widget/source_manga_grid.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourceSearchDelegate extends SearchDelegate<SourceManga?> {
  final ExploreSourceBLoC bloc;

  SourceSearchDelegate({Key? key, required this.bloc});

  @override
  void close(BuildContext context, SourceManga? result) {
    bloc.add(const ExploreSourceEvent.search(''));
    super.close(context, result);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    bloc.add(ExploreSourceEvent.search(query));
    return HookConsumer(
      builder: (context, ref, child) {
        final scrollController = useScrollController(keys: [bloc]);
        useEffect(() {
          scrollController.addListener(() {
            if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
              bloc.add(const ExploreSourceEvent.load());
            }
          });
          return null;
        }, [scrollController]);
        return SourceMangaGrid(
          mangas: ref.watch(ExploreSourceBLoC.provider.select((value) => value.pages)).fold(<SourceManga>[], (result, page) => [...result, ...page.mangas]),
          scrollController: scrollController,
          didTap: (context, manga) => Screen.mangaDetail(manga).push(context),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

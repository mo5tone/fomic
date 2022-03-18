import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/route/screen.dart';
import 'package:fomic/feature/explore_source/bloc.dart';
import 'package:fomic/feature/explore_source/widget/explore_source_grid.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExploreSourceSearchDelegate extends SearchDelegate<MangaInfo?> {
  final ExploreSourceBLoC bloc;

  ExploreSourceSearchDelegate({Key? key, required this.bloc});

  @override
  void close(BuildContext context, MangaInfo? result) {
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
        final scrollController = useScrollController();
        useEffect(() {
          scrollController.addListener(() {
            if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
              bloc.add(const ExploreSourceEvent.load());
            }
          });
          return null;
        }, [scrollController]);
        return ExploreSourceGrid(
          mangas: ref.watch(ExploreSourceBLoC.provider.select((value) => value.pages)).fold(<MangaInfo>[], (result, page) => [...result, ...page.mangas]),
          scrollController: scrollController,
          didTap: (context, manga) => Screen.mangaInfo(manga).push(context),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

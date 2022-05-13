import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/route/screen.dart';
import 'package:fomic/feature/widget/source_filter_sheet.dart';
import 'package:fomic/feature/widget/source_manager_sheet.dart';
import 'package:fomic/feature/widget/source_manga_grid.dart';
import 'package:fomic/feature/widget/source_search_delegate.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/repository/source/online/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'bloc.dart';

class ExploreSourceView extends HookConsumerWidget {
  const ExploreSourceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(HTTPSource.provider);
    final bloc = ref.watch(ExploreSourceBLoC.provider.notifier);
    useEffect(() {
      bloc.add(const ExploreSourceEvent.refresh());
      return null;
    }, [bloc]);
    final scrollController = useScrollController(keys: [bloc]);
    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.extentAfter == 0) {
          bloc.add(const ExploreSourceEvent.load());
        }
      });
      return null;
    }, [scrollController]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.extension),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => SourceManagerSheet(),
            isScrollControlled: true,
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              source.iconName,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(source.name),
          ],
        ),
        actions: <Widget>[
          if (source.filters.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () async {
                final filters = await showModalBottomSheet<List<SourceFilter>>(
                  context: context,
                  builder: (context) => const SourceFilterSheet(),
                  isScrollControlled: true,
                );
                if (filters != null) {
                  bloc.add(ExploreSourceEvent.filter(filters));
                }
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () => showSearch(context: context, delegate: SourceSearchDelegate(bloc: bloc)),
      ),
      body: RefreshIndicator(
        child: SourceMangaGrid(
          mangas: ref.watch(ExploreSourceBLoC.provider.select((value) => value.pages)).fold(<SourceManga>[], (result, page) => [...result, ...page.mangas]),
          scrollController: scrollController,
          didTap: (context, manga) => Screen.mangaDetail(manga).push(context),
        ),
        onRefresh: () => Future(() => bloc.add(const ExploreSourceEvent.refresh())),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/feature/explore_source/widget/explore_source_grid.dart';
import 'package:fomic/feature/explore_source/widget/explore_source_search_delegate.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/route/screen.dart';
import 'package:fomic/model/manga_info.dart';

import 'bloc.dart';

class ExploreSourceView extends HookConsumerWidget {
  const ExploreSourceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.read(ExploreSourceBLoC.provider.notifier);
    useEffect(() {
      bloc.add(const ExploreSourceEvent.refresh());
      return null;
    }, [bloc]);
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          bloc.add(const ExploreSourceEvent.load());
        }
      });
      return null;
    }, [scrollController]);
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(HttpSource.provider).name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: ExploreSourceSearchDelegate(bloc: bloc)),
          ),
          if (ref.watch(HttpSource.provider).filters.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => _FiltersBottomSheet(),
                );
              },
            ),
        ],
      ),
      body: RefreshIndicator(
        child: ExploreSourceGrid(
          mangas: ref.watch(ExploreSourceBLoC.provider.select((value) => value.pages)).fold(<MangaInfo>[], (result, page) => [...result, ...page.mangas]),
          scrollController: scrollController,
          didTap: (context, manga) => Screen.mangaInfo(manga).push(context),
        ),
        onRefresh: () => Future(() => bloc.add(const ExploreSourceEvent.refresh())),
      ),
    );
  }
}

class _FiltersBottomSheet extends HookConsumerWidget {
  static final filtersProvider = StateProvider((ref) => ref.read(HttpSource.provider).filters);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.read(ExploreSourceBLoC.provider.notifier);
    ref.listen<List<Filter>>(
      ExploreSourceBLoC.provider.select((value) => value.filters),
      (previous, next) {
        if (next.isNotEmpty) {
          ref.read(filtersProvider.notifier).state = next;
        } else {
          ref.read(filtersProvider.notifier).state = ref.read(HttpSource.provider).filters;
        }
      },
    );
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextButton(
                  child: const Text('Reset'),
                  onPressed: () {
                    bloc.add(const ExploreSourceEvent.filter([]));
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  child: const Text('Filter'),
                  onPressed: () {
                    bloc.add(ExploreSourceEvent.filter(ref.read(filtersProvider)));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const Divider(),
            for (var i = 0; i < ref.watch(filtersProvider).length; i++)
              _FilterWidget(
                index: i,
              ),
          ],
        ),
      ),
    );
  }
}

class _FilterWidget extends HookConsumerWidget {
  final int _index;

  const _FilterWidget({Key? key, required int index})
      : _index = index,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = StateProvider((ref) => ref.watch(_FiltersBottomSheet.filtersProvider)[_index]);
    return ref.read(provider).when(
          header: (name) => Text(name),
          separator: () => const Divider(),
          select: (name, options, index) {
            return Row(
              children: [
                Text(name),
                const Spacer(),
                DropdownButton<String>(
                  value: options[ref.watch(provider.select((value) => (value as FilterSelect).state))],
                  items: options
                      .map(
                        (o) => DropdownMenuItem(
                          value: o,
                          child: Text(o),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      final newFilter = (ref.read(provider.notifier).state as FilterSelect).copyWith(state: options.indexOf(newValue));
                      ref.read(provider.notifier).update((state) => newFilter);
                      ref.read(_FiltersBottomSheet.filtersProvider.notifier).update((state) => state..[_index] = newFilter);
                    }
                  },
                )
              ],
            );
          },
          text: (name, value) => Container(),
          check: (name, value) => Container(),
          group: (name, filterList) => Container(),
          sort: (name, options, index, isfas) => Container(),
        );
  }
}

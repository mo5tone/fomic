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
              onPressed: () async {
                final filters = await showModalBottomSheet<List<Filter>>(
                  context: context,
                  builder: (context) => const _FiltersBottomSheet(),
                  isScrollControlled: true,
                );
                if (filters != null) {
                  bloc.add(ExploreSourceEvent.filter(filters));
                }
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
  static final filters = StateProvider((ref) => ref.read(HttpSource.provider).filters);

  const _FiltersBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    ref.refresh(filters);
                    Navigator.of(context).pop(<Filter>[]);
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  child: const Text('Filter'),
                  onPressed: () {
                    Navigator.of(context).pop(ref.read(filters));
                  },
                ),
              ],
            ),
            const Divider(),
            ...ref.watch(filters).map((f) => _FilterWidget(filter: f)).toList(growable: false),
          ],
        ),
      ),
    );
  }
}

class _FilterWidget extends HookConsumerWidget {
  final Filter filter;

  const _FilterWidget({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void update({required Filter filter}) {
      ref.read(_FiltersBottomSheet.filters.notifier).update((state) => state.map((f) => f.name == filter.name ? filter : f).toList(growable: false));
    }

    return filter.when(
      header: (name) => Text(name),
      separator: (_) => const Divider(),
      select: (name, options, state) => Row(
        children: [
          Text(name),
          const Spacer(),
          DropdownButton<String>(
            value: options[state],
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
                update(filter: (filter as FilterSelect).copyWith(state: options.indexOf(newValue)));
              }
            },
          ),
        ],
      ),
      text: (name, state) {
        final textEditingController = useTextEditingController(text: state);
        return Row(
          children: [
            Text(name),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: 8,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: TextField(
                  controller: textEditingController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (newValue) {
                    update(filter: (filter as FilterText).copyWith(state: newValue));
                  },
                ),
              ),
            ),
          ],
        );
      },
      check: (name, value) => Row(
        children: [
          Text(name),
          const Spacer(),
          Switch(
            value: value,
            onChanged: (newValue) {
              update(filter: (filter as FilterCheck).copyWith(state: newValue));
            },
          ),
        ],
      ),
      sort: (name, options, state, ascending) => Row(
        children: [
          Text(name),
          const Spacer(),
          DropdownButton<String>(
            value: options[state],
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
                update(filter: (filter as FilterSort).copyWith(state: options.indexOf(newValue)));
              }
            },
          ),
          const Spacer(),
          Switch(
            value: ascending,
            onChanged: (newValue) {
              update(filter: (filter as FilterSort).copyWith(ascending: newValue));
            },
          ),
        ],
      ),
    );
  }
}

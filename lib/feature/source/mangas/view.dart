import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/route/screen.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/source.dart';

import 'bloc.dart';
import 'widget/mangas_grid.dart';

class SourceMangasView extends HookConsumerWidget {
  const SourceMangasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.read(SourceMangasBLoC.provider.notifier);
    useEffect(() {
      bloc.add(const SourceMangasEvent.refresh());
      return null;
    }, [bloc]);
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          bloc.add(const SourceMangasEvent.load());
        }
      });
      return null;
    }, [scrollController]);
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(Source.provider).name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(context: context, delegate: BooksSearchDelegate()).then((value) => _didTap(context, value)).catchError((err) => null);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: MangasGrid(
          mangas: ref.watch(SourceMangasBLoC.provider.select((value) => value.pages)).fold(<MangaInfo>[], (result, page) => result..addAll(page.mangas)),
          scrollController: scrollController,
          didTap: (context, manga) => Screen.mangaInfo(manga).push(context),
        ),
        onRefresh: () => Future(() => bloc.add(const SourceMangasEvent.refresh())),
      ),
    );
  }
}

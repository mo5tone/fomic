import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/feature/chapter_info/bloc.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChapterInfoView extends HookConsumerWidget {
  final StateNotifierProvider<ChapterInfoBLoC, ChapterInfoState> provider;

  ChapterInfoView({Key? key, required ChapterInfo chapter})
      : provider = ChapterInfoBLoC.family(chapter),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.read(provider.notifier);
    useEffect(() {
      bloc.add(const ChapterInfoEvent.refresh());
      return null;
    });
    final pageController = usePageController();
    useEffect(() {
      pageController.addListener(() {});
      return null;
    }, [pageController]);
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(provider.select((state) => state.chapter.name))),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.values[ref.watch(provider.select((state) => state.axis))],
        controller: pageController,
        itemCount: ref.watch(provider.select((state) => state.pages.length)),
        onPageChanged: (index) {},
        itemBuilder: (context, index) {
          final page = ref.watch(provider.select((state) => state.pages[index]));
          return page.when(
            url: (url) => CachedNetworkImage(
              imageUrl: url,
              httpHeaders: ref.read(HttpSource.provider).headers,
              fit: BoxFit.cover,
            ),
            imageUrl: (imageUrl) => CachedNetworkImage(
              imageUrl: imageUrl,
              httpHeaders: ref.read(HttpSource.provider).headers,
              fit: BoxFit.cover,
            ),
            imageBase64: (imageBase64) => Image.memory(base64.decode(imageBase64)),
            text: (text) => Text(text),
          );
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/common/widget/marquee.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/repository/source/online/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'bloc.dart';

class ReaderView extends HookConsumerWidget {
  final SourceChapter chapter;

  const ReaderView({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ReaderBLoC.family(chapter);
    final bloc = ref.watch(provider.notifier);
    useEffect(() {
      bloc.add(const ReaderEvent.refresh());
      return null;
    }, [bloc]);
    final pageController = usePageController(keys: [bloc]);
    useEffect(() {
      pageController.addListener(() {});
      return null;
    }, [pageController]);
    return Scaffold(
      appBar: AppBar(
        title: Marquee(
          child: Text(ref.watch(provider.select((state) => state.chapter.name))),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView.builder(
              scrollDirection: Axis.values[ref.watch(provider.select((state) => state.axis)) % Axis.values.length],
              controller: pageController,
              itemCount: ref.watch(provider.select((state) => state.pages.length)),
              onPageChanged: (index) => bloc.add(ReaderEvent.pageChanged(index)),
              itemBuilder: (context, index) {
                final page = ref.watch(provider.select((state) => state.pages[index]));
                return Center(
                  child: page.when(
                    url: (url) => CachedNetworkImage(
                      imageUrl: url,
                      cacheManager: ref.watch(HTTPSource.provider).cacheManager,
                      fit: BoxFit.contain,
                    ),
                    imageUrl: (imageUrl) => CachedNetworkImage(
                      imageUrl: imageUrl,
                      cacheManager: ref.watch(HTTPSource.provider).cacheManager,
                      fit: BoxFit.contain,
                    ),
                    imageBase64: (imageBase64) => Image.memory(base64.decode(imageBase64)),
                    text: (text) => Text(text),
                  ),
                );
              },
            ),
            if (ref.watch(provider.select((state) => state.pages.isNotEmpty)))
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Column(
                  children: [
                    if (ref.watch(provider.select((state) => state.pages.length > 1)))
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Slider(
                          value: ref.watch(provider.select((state) => state.index + 1)),
                          onChanged: (value) => pageController.jumpToPage(value.round()),
                          label: '${ref.watch(provider.select((state) => state.index + 1))}',
                          min: 1,
                          max: ref.watch(provider.select((state) => state.pages.length.roundToDouble())),
                          divisions: ref.watch(provider.select((state) => state.pages.length)),
                        ),
                      ),
                    Text(
                      ref.watch(
                          provider.select((state) => '${NumberFormat('0' * '${state.pages.length}'.length).format(state.index + 1)} / ${state.pages.length}')),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

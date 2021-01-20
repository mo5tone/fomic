import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/notifier/hud_state_notifier.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/model/chapter.dart';
import 'package:fomic/extension/extended_image_state_x.dart';
import 'package:fomic/source/model/page.dart';
import 'package:fomic/source/source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part './notifier.dart';

class PagesScreen extends HookWidget {
  final Book book;
  final Chapter chapter;
  final StateNotifierProvider<PagesStateNotifier> notifierProvider;

  PagesScreen({Key key, this.book, this.chapter})
      : notifierProvider = rpPagesStateNotifier(chapter),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final theme = Theme.of(context);
    final pages = useProvider(notifierProvider.state).pages;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Column(
          children: [
            Text('${book.title}'),
            Text(
              '${chapter.name}',
              style: theme.textTheme.subtitle2.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // TODO: implement read setting
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ExtendedImageGesturePageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (value) => context.read(notifierProvider).currentIndex = value,
            itemBuilder: (ctx, idx) {
              final page = pages[idx];
              return ExtendedImage.network(
                page.imageUrl,
                headers: page.imageHeaders.map((key, value) => MapEntry(key, '$value')),
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                loadStateChanged: (state) => state.loadStateWidget(true),
                initGestureConfigHandler: (state) => GestureConfig(
                  inPageView: true,
                  initialScale: 1,
                  cacheGesture: false,
                ),
              );
            },
          ),
          Consumer(
            builder: (context, watch, child) {
              final index = watch(notifierProvider.state).currentIndex + 1;
              return Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    index == null ? '' : '${index + 1} / ${pages.length + 1}',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

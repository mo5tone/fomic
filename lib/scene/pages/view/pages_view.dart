import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fomic/scene/pages/view_model/pages_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/utils/extension/extended_image_state.dart';

class PagesView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<PagesViewModel, PagesView> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pages = context.select((PagesViewModel value) => value.pages);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('${vm.book.title}'),
            Text(
              '${vm.chapter.name}',
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
              // TODO:
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ExtendedImageGesturePageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (value) => vm.index = value,
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
          Selector<PagesViewModel, int>(
            selector: (_, value) => value.index,
            builder: (_, index, __) => Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  index == null ? '' : '${index + 1} / ${pages.length + 1}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

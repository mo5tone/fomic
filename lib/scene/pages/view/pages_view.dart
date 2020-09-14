import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fomic/utils/networking_image.dart';
import 'package:provider/provider.dart';
import 'package:fomic/scene/pages/view_model/pages_view_model.dart';
import 'package:fomic/scene/view.dart';

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
            onPressed: () {},
          ),
        ],
      ),
      body: ExtendedImageGesturePageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (ctx, idx) {
          final page = pages[idx];
          return NetworkingImage(
            page.image.uri.toString(),
            headers: page.image.headers.map((key, value) => MapEntry(key, '$value')),
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) => GestureConfig(
              inPageView: true,
              initialScale: 1,
              cacheGesture: false,
            ),
          );
        },
      ),
    );
  }
}

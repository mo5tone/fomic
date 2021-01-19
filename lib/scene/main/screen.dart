import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final _rpSelectedIndex = StateProvider((ref) => 0);

class MainScreen extends HookWidget {
  final Widget Function(BuildContext, int) builder;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  MainScreen({Key key, @required this.builder, this.bottomNavigationBarItems = const []})
      : assert(builder != null),
        assert(bottomNavigationBarItems != null && bottomNavigationBarItems.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return ProviderListener(
      provider: _rpSelectedIndex,
      onChange: (context, StateController<int> controller) {
        pageController.animateToPage(controller.state, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
      },
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: builder,
          itemCount: bottomNavigationBarItems.length,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavigationBarItems,
          onTap: (index) {
            context.read(_rpSelectedIndex).state = index;
          },
          currentIndex: useProvider(_rpSelectedIndex).state,
        ),
      ),
    );
  }
}

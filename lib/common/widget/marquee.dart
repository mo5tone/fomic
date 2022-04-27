import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Marquee extends HookConsumerWidget {
  final Widget child;
  final Axis direction;
  final Duration duration;

  const Marquee({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    useEffect(() {
      const stayDuration = Duration(milliseconds: 500);
      var count = 0;
      Timer? timer;
      scrollController.addListener(() {
        if (timer == null && scrollController.hasClients) {
          final animationDuration = duration * (scrollController.position.extentInside / 200);
          timer = Timer.periodic(animationDuration + stayDuration, (timer) {
            final offset = count % 2 == 1 ? scrollController.position.minScrollExtent : scrollController.position.maxScrollExtent;
            scrollController.animateTo(offset, duration: animationDuration, curve: Curves.linear).then((_) => count += 1);
          });
        }
      });
      Future.delayed(stayDuration).then((_) => scrollController.jumpTo(1)); // Trigger scrollController's listeners
      return () => timer?.cancel();
    }, [scrollController]);
    return SingleChildScrollView(
      child: child,
      scrollDirection: direction,
      controller: scrollController,
    );
  }
}

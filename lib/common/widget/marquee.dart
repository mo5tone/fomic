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
      var count = 0;
      final timer = Timer.periodic(Duration(milliseconds: duration.inMilliseconds + 500), (timer) async {
        final offset = count % 2 == 1 ? scrollController.position.minScrollExtent : scrollController.position.maxScrollExtent;
        await scrollController.animateTo(
          offset,
          duration: duration,
          curve: Curves.linear,
        );
        count += 1;
      });
      return () {
        timer.cancel();
      };
    }, [scrollController]);
    return SingleChildScrollView(
      child: child,
      scrollDirection: direction,
      controller: scrollController,
    );
  }
}

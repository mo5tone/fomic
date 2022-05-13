import 'package:flutter/material.dart';
import 'package:fomic/repository/service/source_box.dart';
import 'package:fomic/repository/source/configurable_source.dart';
import 'package:fomic/repository/source/online/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourceManagerSheet extends HookConsumerWidget {
  static const maxHeightFactor = 1.0;
  static const defaultHeightFactor = 0.3;
  final heightFactor = StateProvider((ref) => defaultHeightFactor);

  SourceManagerSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final all = ref.watch(HTTPSource.all);
    final isFullscreen = ref.watch(heightFactor) > defaultHeightFactor;
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: SafeArea(
        child: FractionallySizedBox(
          heightFactor: ref.watch(heightFactor),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ref.read(heightFactor.notifier).update((state) => isFullscreen ? defaultHeightFactor : maxHeightFactor);
                      },
                      icon: Icon(isFullscreen ? Icons.close_fullscreen : Icons.open_in_full),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: all.length,
                    itemBuilder: (context, index) {
                      final source = all[index];
                      final configurable = source is ConfigurableSource;
                      final selected = source.id == ref.watch(HTTPSource.provider).id;
                      return ListTile(
                        selected: selected,
                        leading: Image.asset(source.iconName),
                        title: Text(source.name),
                        trailing: configurable
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.tune),
                              )
                            : null,
                        onTap: () {
                          ref.watch(HTTPSource.provider.notifier).update((state) => source);
                          ref.watch(SourceBox.provider).whenOrNull(data: (box) => box)?.id = source.id;
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

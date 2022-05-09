import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/l10n/l10n.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/repository/source/online/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourceFilterSheet extends HookConsumerWidget {
  static final filters = StateProvider((ref) => ref.watch(HTTPSource.provider).filters);

  const SourceFilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void update({required SourceFilter filter}) {
      ref.read(filters.notifier).update((state) => state.map((f) => f.name == filter.name ? filter : f).toList(growable: false));
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextButton(
                  child: Text(L10N.of(context).reset),
                  onPressed: () {
                    ref.refresh(filters);
                    Navigator.of(context).pop(<SourceFilter>[]);
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  child: Text(L10N.of(context).filter),
                  onPressed: () {
                    Navigator.of(context).pop(ref.read(filters));
                  },
                ),
              ],
            ),
            const Divider(),
            ...ref.watch(filters).map((filter) {
              return filter.map(
                header: (f) => Row(
                  children: [
                    Text(f.name),
                  ],
                ),
                separator: (f) => const Divider(),
                select: (f) => Row(
                  children: [
                    Text(f.name),
                    const Spacer(),
                    DropdownButton<String>(
                      value: f.options[f.state],
                      items: f.options
                          .map(
                            (o) => DropdownMenuItem(
                              value: o,
                              child: Text(o),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          update(filter: f.copyWith(state: f.options.indexOf(newValue)));
                        }
                      },
                    ),
                  ],
                ),
                text: (f) {
                  final textEditingController = useTextEditingController(text: f.state);
                  return Row(
                    children: [
                      Text(f.name),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 8,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: TextField(
                            controller: textEditingController,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (newValue) {
                              update(filter: f.copyWith(state: newValue));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                check: (f) => Row(
                  children: [
                    Text(f.name),
                    const Spacer(),
                    Switch(
                      value: f.state,
                      onChanged: (newValue) {
                        update(filter: f.copyWith(state: newValue));
                      },
                    ),
                  ],
                ),
                sort: (f) => Row(
                  children: [
                    Text(f.name),
                    const Spacer(),
                    DropdownButton<String>(
                      value: f.options[f.state],
                      items: f.options
                          .map(
                            (o) => DropdownMenuItem(
                              value: o,
                              child: Text(o),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          update(filter: f.copyWith(state: f.options.indexOf(newValue)));
                        }
                      },
                    ),
                    const Spacer(),
                    Switch(
                      value: f.ascending,
                      onChanged: (newValue) {
                        update(filter: f.copyWith(ascending: newValue));
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

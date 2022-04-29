import 'package:flutter/material.dart';
import 'package:fomic/repository/service/source_box.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourcePickerDialog extends HookConsumerWidget {
  const SourcePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...ref.watch(HTTPSource.all).map((source) {
              final selected = source.id == ref.watch(HTTPSource.provider).id;
              return ListTile(
                leading: Image.asset(source.iconName),
                title: Text(source.name),
                trailing: selected ? const Icon(Icons.check) : null,
                selected: selected,
                onTap: () {
                  ref.watch(HTTPSource.provider.notifier).update((state) => source);
                  ref.watch(SourceBox.provider).whenOrNull(data: (box) => box)?.id = source.id;
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

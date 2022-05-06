import 'package:flutter/material.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SourceSetting extends HookConsumerWidget {
  const SourceSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(HTTPSource.provider);
    final noItems = source.settingItemCount < 1 || source.settingItemBuilder == null;
    return Scaffold(
      appBar: AppBar(
        title: Text('${source.name} Setting'),
      ),
      body: SafeArea(
        child: noItems
            ? const Center(
                child: Text('No Setting Items'),
              )
            : ListView.builder(
                itemCount: source.settingItemCount,
                itemBuilder: source.settingItemBuilder!,
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fomic/constant/routing.dart';
import 'package:fomic/constant/source_id.dart';
import 'package:hooks_riverpod/all.dart';

class ExploreScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selectedSourceId = useProvider(rpSourceId).state;
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: ListView.separated(
        itemBuilder: (ctx, idx) {
          final sourceId = SourceId.values[idx];
          final isSelected = selectedSourceId == sourceId;
          return ListTile(
            title: Text('${sourceId.name}'),
            subtitle: Text('${sourceId.languageCode}'),
            trailing: Icon(isSelected ? Icons.check : Icons.chevron_right),
            onTap: () {
              ctx.read(rpSourceId).state = sourceId;
              Routing.books.push(ctx);
            },
          );
        },
        separatorBuilder: (ctx, idx) => Divider(
          indent: 8,
          endIndent: 8,
          color: Colors.black38,
        ),
        itemCount: SourceId.values.length,
      ),
    );
  }
}

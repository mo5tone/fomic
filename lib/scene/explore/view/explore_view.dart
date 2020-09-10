import 'package:flutter/material.dart';
import 'package:fomic/model/constant/routing.dart';
import 'package:provider/provider.dart';
import 'package:fomic/scene/view.dart';
import 'package:fomic/scene/explore/view_model/explore_view_model.dart';
import 'package:fomic/model/constant/source_id.dart';

class ExploreView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<ExploreViewModel, ExploreView> {
  @override
  Widget build(BuildContext context) {
    final selectedSourceId = context.select((ExploreViewModel value) => value.selectedSourceId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: ListView.separated(
        itemBuilder: (ctx, idx) {
          final sourceId = vm.sourceIds[idx];
          final selected = selectedSourceId == sourceId;
          return ListTile(
            title: Text('${sourceId.name}'),
            subtitle: Text('${sourceId.languageCode}'),
            trailing: Icon(selected ? Icons.check : Icons.chevron_right),
            onTap: () {
              Routing.books.push(ctx, arguments: sourceId);
              vm.selectedSourceId = sourceId;
            },
          );
        },
        separatorBuilder: (ctx, idx) => Divider(
          indent: 8,
          endIndent: 8,
          color: Colors.black38,
        ),
        itemCount: vm.sourceIds.length,
      ),
    );
  }
}

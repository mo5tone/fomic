import 'package:flutter/material.dart';
import 'package:fomic/model/filter.dart';

class FiltersWidget extends StatelessWidget {
  final List<Filter> filters;

  const FiltersWidget({Key key, this.filters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filters.length,
              itemBuilder: (ctx, index) {
                final filter = filters[index];
                if (filter is SelectableFilter) {
                  return _SelectableFilterWidget(
                    filter: filter,
                  );
                } else if (filter is SwitchableFilter) {
                  return _SwitchableFilterWidget(
                    filter: filter,
                  );
                }
                return Divider();
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('Reset'),
                ),
              ),
              Spacer(),
              Expanded(
                flex: 8,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('OK'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SwitchableFilterWidget extends StatelessWidget {
  final SwitchableFilter filter;

  const _SwitchableFilterWidget({Key key, this.filter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Text(filter.name),
          ),
          Switch(
            value: filter.state,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class _SelectableFilterWidget extends StatelessWidget {
  final SelectableFilter filter;

  const _SelectableFilterWidget({Key key, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(filter.name),
          ),
          Spacer(),
          Expanded(
            flex: 10,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filter.aliases.map((key) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(key),
                  ],
                );
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

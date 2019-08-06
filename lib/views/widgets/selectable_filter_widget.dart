import 'package:flutter/material.dart';
import 'package:fomic/model/filter.dart';

class SelectableFilterWidget extends StatelessWidget {
  final SelectableFilter filter;

  const SelectableFilterWidget({Key key, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4),
          child: Text(filter.name),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
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
        ),
      ],
    );
  }
}

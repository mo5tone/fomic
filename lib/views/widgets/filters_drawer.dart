import 'package:flutter/material.dart';
import 'package:fomic/model/filter.dart';

class FiltersDrawer extends StatefulWidget {
  final List<Filter> filters;
  final void Function() onApply;

  const FiltersDrawer({Key key, this.filters, this.onApply}) : super(key: key);

  @override
  _FiltersDrawerState createState() => _FiltersDrawerState();
}

class _FiltersDrawerState extends State<FiltersDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.filters.length,
                itemBuilder: (ctx, index) {
                  final filter = widget.filters[index];
                  if (filter is SelectableFilter) {
                    return _SelectableFilterItem(
                      filter: filter,
                    );
                  } else if (filter is SwitchableFilter) {
                    return _SwitchableFilterItem(
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
                  child: FlatButton(
                    child: Text('Reset'),
                    onPressed: () {
                      setState(() {
                        widget.filters.forEach((filter) => filter.reset());
                      });
                    },
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 8,
                  child: FlatButton(
                    child: Text('Apply'),
                    onPressed: () {
                      if (widget.onApply != null) {
                        widget.onApply();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchableFilterItem extends StatefulWidget {
  final SwitchableFilter filter;

  const _SwitchableFilterItem({Key key, this.filter}) : super(key: key);

  @override
  _SwitchableFilterItemState createState() => _SwitchableFilterItemState();
}

class _SwitchableFilterItemState extends State<_SwitchableFilterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Text(widget.filter.name),
          ),
          Switch(
            value: widget.filter.state,
            onChanged: (value) {
              setState(() {
                widget.filter.state = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _SelectableFilterItem extends StatefulWidget {
  final SelectableFilter filter;

  const _SelectableFilterItem({Key key, this.filter}) : super(key: key);

  @override
  _SelectableFilterItemState createState() => _SelectableFilterItemState();
}

class _SelectableFilterItemState extends State<_SelectableFilterItem> {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < widget.filter.aliases.length; i++) {
      final alias = widget.filter.aliases[i];
      children.add(GestureDetector(
        onTap: () {
          setState(() {
            widget.filter.state = i;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  color: i == widget.filter.state
                      ? Theme.of(context).colorScheme.background
                      : null,
                  child: Text(
                    alias,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(widget.filter.name),
            ),
          ),
//          Spacer(),
          Expanded(
            flex: 5,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

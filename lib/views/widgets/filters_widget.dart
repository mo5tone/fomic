import 'package:flutter/material.dart';
import 'package:fomic/model/filter.dart';

class FiltersWidget extends StatefulWidget {
  final List<Filter> filters;
  final void Function() onApply;

  const FiltersWidget({Key key, this.filters, this.onApply}) : super(key: key);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.filters.length,
              itemBuilder: (ctx, index) {
                final filter = widget.filters[index];
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
    );
  }
}

class _SwitchableFilterWidget extends StatefulWidget {
  final SwitchableFilter filter;

  const _SwitchableFilterWidget({Key key, this.filter}) : super(key: key);

  @override
  _SwitchableFilterWidgetState createState() => _SwitchableFilterWidgetState();
}

class _SwitchableFilterWidgetState extends State<_SwitchableFilterWidget> {
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

class _SelectableFilterWidget extends StatefulWidget {
  final SelectableFilter filter;

  const _SelectableFilterWidget({Key key, this.filter}) : super(key: key);
  @override
  _SelectableFilterWidgetState createState() => _SelectableFilterWidgetState();
}

class _SelectableFilterWidgetState extends State<_SelectableFilterWidget> {
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
            child: Text(widget.filter.name),
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

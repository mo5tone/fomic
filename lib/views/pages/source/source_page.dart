import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/source/bloc.dart';
import 'package:fomic/blocs/source/event.dart';
import 'package:fomic/blocs/source/state.dart';
import 'package:fomic/model/filter.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/views/widgets/comic_widget.dart';

class SourcePage extends StatelessWidget {
  final Source source;

  const SourcePage({Key key, @required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (ctx) =>
          SourceBloc(source)..dispatch(SourceEvent(SourceEventType.fetch)),
      child: _SourcePage(),
    );
  }
}

class _SourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SourceBloc>(context);
    return BlocBuilder<SourceBloc, SourceState>(
      builder: (ctx, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${state.source.name}'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  // todo
                  showModalBottomSheet(
                    context: ctx,
                    builder: (ctx) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          child: Container(
                            color: Colors.red,
                            // todo: fuck this options list.
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.source.filters.length,
                              itemBuilder: (ctx, groupIndex) {
                                var filter = state.source.filters[groupIndex];
                                if (filter is SelectableFilter) {
                                  var index = 0;
                                  return DropdownButton(
                                    value: filter.state,
                                    items: filter.keys
                                        .map((key) => DropdownMenuItem<int>(
                                              child: Text(key),
                                              value: index++,
                                            ))
                                        .toList(growable: false),
                                    onChanged: (value) {
                                      print('onChanged: $value');
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 10 / 13,
                ),
                itemCount: state.comics.length,
                itemBuilder: (ctx, index) =>
                    ComicWidget(comic: state.comics[index]),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(state.isSearching ? Icons.close : Icons.search),
              onPressed: () {
                bloc.dispatch(SourceEvent(SourceEventType.setQuery, query: ''));
                if (state.isSearching) {
                  bloc.dispatch(SourceEvent(SourceEventType.endSearching));
                } else {
                  bloc.dispatch(SourceEvent(SourceEventType.startSearching));
                }
              }),
        );
      },
    );
  }
}

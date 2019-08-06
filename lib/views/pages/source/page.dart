import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/source/bloc.dart';
import 'package:fomic/blocs/source/event.dart';
import 'package:fomic/blocs/source/state.dart';
import 'package:fomic/sources/base/source.dart';
import 'package:fomic/views/widgets/comic_widget.dart';
import 'package:fomic/views/widgets/filters_widget.dart';

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
    final textEditingController = TextEditingController();
    return BlocBuilder<SourceBloc, SourceState>(
      builder: (ctx, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: Theme.of(ctx).platform == TargetPlatform.iOS,
            title: state.isSearching
                ? TextField(
                    autofocus: true,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          bloc.dispatch(
                              SourceEvent(SourceEventType.setQuery, query: ''));
                          bloc.dispatch(
                              SourceEvent(SourceEventType.endSearching));
                        },
                      ),
                      hintText: 'Keyword',
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (query) {
                      print(query);
                    },
                  )
                : Text('${state.source.name}'),
            actions: [
              if (!state.isSearching)
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    bloc.dispatch(
                        SourceEvent(SourceEventType.setQuery, query: ''));
                    bloc.dispatch(SourceEvent(SourceEventType.startSearching));
                  },
                ),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  // todo
                  showModalBottomSheet(
                    context: ctx,
                    builder: (ctx) {
                      return SafeArea(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Container(
                              color: Theme.of(ctx).cardColor,
                              child: FiltersWidget(
                                filters: state.source.filters,
                              ),
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
        );
      },
    );
  }
}

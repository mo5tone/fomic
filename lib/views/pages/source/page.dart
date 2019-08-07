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
      builder: (context) {
        return SourceBloc(source)..dispatch(SourceEvent(SourceEventType.fetch));
      },
      child: _SourcePage(),
    );
  }
}

class _SourcePage extends StatefulWidget {
  @override
  __SourcePageState createState() => __SourcePageState();
}

class __SourcePageState extends State<_SourcePage> {
  SourceBloc bloc;
  TextEditingController textEditingController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Widget filtersBottomSheet(BuildContext context, SourceState state) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Container(
            color: Theme.of(context).cardColor,
            child: FiltersWidget(
              filters: state.source.filters,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context, SourceState state) {
    if (state.isSearching) {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            bloc.dispatch(SourceEvent(SourceEventType.endSearching));
          },
        ),
        title: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Keyword',
          ),
          onSubmitted: (query) {
            bloc.dispatch(SourceEvent(
              SourceEventType.fetch,
              query: query ?? '',
            ));
          },
        ),
      );
    } else {
      return AppBar(
        centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
        title: Text('${state.source.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.dispatch(SourceEvent(SourceEventType.startSearching));
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // todo: show endDrawer.
              _scaffoldKey.currentState.openEndDrawer();
            },
          ),
        ],
      );
    }
  }

  Widget body(BuildContext context, SourceState state) {
    return SafeArea(
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
          itemBuilder: (context, index) => ComicWidget(
            comic: state.comics[index],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SourceBloc>(context);
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceBloc, SourceState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: appBar(context, state),
          endDrawer: Drawer(
            child: FiltersWidget(
              filters: state.source.filters,
            ),
          ),
          body: body(context, state),
        );
      },
    );
  }
}

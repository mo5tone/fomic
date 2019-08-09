import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/comic/bloc.dart';
import 'package:fomic/blocs/comic/event.dart';
import 'package:fomic/blocs/comic/state.dart';
import 'package:fomic/model/comic.dart';

class ComicPage extends StatelessWidget {
  final Comic comic;

  const ComicPage({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return ComicBloc(comic)..dispatch(ComicEvent(ComicEventType.fetch));
      },
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  ComicBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ComicBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComicBloc, ComicState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('${state.comic.title}'),
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height / 3,
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        child: Center(
                          child: Text('${state.chapters[index].name}'),
                        ),
                      );
                    },
                    childCount: state.chapters.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 4 / 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
          appBar: AppBar(),
          body: SafeArea(
            child: Container(),
          ),
        );
      },
    );
  }
}

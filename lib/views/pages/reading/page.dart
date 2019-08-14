import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/reading/bloc.dart';
import 'package:fomic/blocs/reading/event.dart';
import 'package:fomic/blocs/reading/state.dart';
import 'package:fomic/model/chapter.dart';

class ReadingPage extends StatelessWidget {
  final Chapter chapter;

  const ReadingPage({Key key, this.chapter})
      : assert(chapter != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return ReadingBloc(chapter)
          ..dispatch(ReadingEvent(ReadingEventType.fetch));
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
  ReadingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ReadingBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadingBloc, ReadingState>(
      listener: (context, state) {
        List<SystemUiOverlay> overlays =
            state.fullPage ? [] : SystemUiOverlay.values;
        SystemChrome.setEnabledSystemUIOverlays(overlays);
      },
      child: BlocBuilder<ReadingBloc, ReadingState>(
        builder: (context, state) {
          final theme = Theme.of(context);
          return Scaffold(
            appBar: PreferredSize(
              child: AnimatedOpacity(
                opacity: state.fullPage ? 0 : 1,
                duration: Duration(milliseconds: 300),
                child: IgnorePointer(
                  ignoring: state.fullPage,
                  child: AppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.chapter.manga.title,
                          style: theme.textTheme.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          state.chapter.name,
                          style: theme.textTheme.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              preferredSize: Size(double.infinity, kToolbarHeight),
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  bloc.dispatch(ReadingEvent(ReadingEventType.toggleOverlay));
                },
                child: Container(
                  color: theme.colorScheme.onPrimary,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

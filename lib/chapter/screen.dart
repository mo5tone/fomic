import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/chapter/bloc.dart';
import 'package:fomic/chapter/event.dart';
import 'package:fomic/chapter/state.dart';
import 'package:fomic/model/chapter.dart';
import 'package:photo_view/photo_view.dart';

class ChapterScreen extends StatelessWidget {
  final Chapter chapter;

  const ChapterScreen({Key key, this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) =>
          ChapterBloc(chapter)..dispatch(ChapterEvent(ChapterEventType.fetch)),
      child: _ChapterPage(),
    );
  }
}

class _ChapterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChapterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${bloc.chapter.name}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // todo: configuration for reading.
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ChapterBloc, ChapterState>(
          builder: (context, state) {
            final pages = state.pages;
            if (pages.isEmpty && state.type == ChapterStateType.fetching) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return PageView.builder(
                controller: PageController(),
                itemCount: pages.length,
                onPageChanged: (index) {
                  // todo: add an indicator
                },
                itemBuilder: (context, index) => CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: pages[index].imageUrl,
                  imageBuilder: (context, provider) => PhotoView(
                    imageProvider: provider,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

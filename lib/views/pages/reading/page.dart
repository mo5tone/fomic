import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/reading/bloc.dart';
import 'package:fomic/blocs/reading/event.dart';
import 'package:fomic/blocs/reading/state.dart';
import 'package:fomic/model/chapter.dart';
import 'package:fomic/model/page.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ReadingPage extends StatelessWidget {
  final Chapter chapter;

  const ReadingPage({Key key, this.chapter})
      : assert(chapter != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return ReadingBloc(chapter)..dispatch(ReadingEvent.fetch());
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
  ReadingBloc _bloc;
  PageController _pageController;
  bool _changedByGesture;

  ThemeData get _theme => Theme.of(context);

  Future<List<ImageProvider>> _prefetchPageList(List<Page> pageList) async {
    final List<ImageProvider> providerList = [];
    final imageConfiguration = createLocalImageConfiguration(context);
    pageList.where((page) => page.imageUrl != null).forEach((page) {
      providerList.add(CachedNetworkImageProvider(
        page.imageUrl,
        headers: page.headers,
      )..resolve(imageConfiguration));
    });
    return providerList;
  }

  void _pageControllerListener() {}

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ReadingBloc>(context);
    _pageController = PageController()..addListener(_pageControllerListener);
    _changedByGesture = true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadingBloc, ReadingState>(
      condition: (previous, current) {
        return previous.fullPage != current.fullPage ||
            previous.pageIndex != current.pageIndex;
      },
      listener: (context, state) {
        final overlays =
            state.fullPage ? <SystemUiOverlay>[] : SystemUiOverlay.values;
        SystemChrome.setEnabledSystemUIOverlays(overlays);
        _pageController.jumpToPage(state.pageIndex);
      },
      child: BlocBuilder<ReadingBloc, ReadingState>(
        condition: (previous, current) {
          return true;
        },
        builder: (context, state) {
          final appBar = PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: IgnorePointer(
              ignoring: state.fullPage,
              child: AnimatedOpacity(
                opacity: state.fullPage ? 0 : 1,
                duration: Duration(milliseconds: 300),
                child: AppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.chapter.manga.title,
                        style: _theme.primaryTextTheme.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        state.chapter.name,
                        style: _theme.primaryTextTheme.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          final pageListSlider = IgnorePointer(
            ignoring: state.fullPage,
            child: AnimatedOpacity(
              opacity: state.fullPage ? 0 : 1,
              duration: kThemeAnimationDuration,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('1'),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Slider(
                          min: 1.0,
                          max: state.pageList.length + 1.0,
                          value: state.pageIndex + 1.0,
                          divisions: state.pageList.length + 1,
                          onChanged: (value) {
                            _changedByGesture = false;
                            final index = value.round();
                            _bloc.dispatch(ReadingEvent.displayPage(index));
                          },
                        ),
                      ),
                    ),
                    Text('${state.pageList.length + 1}'),
                  ],
                ),
              ),
            ),
          );
          return Scaffold(
            appBar: appBar,
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  _bloc.dispatch(ReadingEvent.toggleOverlay());
                },
                child: Container(
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: _prefetchPageList(state.pageList),
                        builder: (context, snapShot) {
                          if (!snapShot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return PhotoViewGallery.builder(
                            pageController: _pageController,
                            backgroundDecoration: BoxDecoration(
                              color: _theme.scaffoldBackgroundColor,
                            ),
                            scrollPhysics: PageScrollPhysics(),
                            itemCount: snapShot.data.length,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: snapShot.data[index],
                              );
                            },
                            onPageChanged: (index) {
                              if (_changedByGesture) {
                                _bloc.dispatch(ReadingEvent.displayPage(index));
                              } else {
                                _changedByGesture = true;
                              }
                            },
                          );
                        },
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: pageListSlider,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

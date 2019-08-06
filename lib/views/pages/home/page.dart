import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/home/bloc.dart';
import 'package:fomic/blocs/home/event.dart';
import 'package:fomic/blocs/home/state.dart';
import 'package:fomic/views/pages/comics/page.dart';
import 'package:fomic/views/pages/downloads/page.dart';
import 'package:fomic/views/pages/settings/page.dart';
import 'package:fomic/views/pages/sources/page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (ctx) => HomeBloc(),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  final List<Widget> _bodies = List.filled(4, Container());

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) {
        var index = 0;
        switch (state.type) {
          case HomeStateType.sourcesPage:
            index = 1;
            if (_bodies[index] is! SourcesPage) {
              _bodies[index] = SourcesPage();
            }
            break;
          case HomeStateType.downloadsPage:
            index = 2;
            if (_bodies[index] is! DownloadsPage) {
              _bodies[index] = DownloadsPage();
            }
            break;
          case HomeStateType.settingsPage:
            index = 3;
            if (_bodies[index] is! SettingsPage) {
              _bodies[index] = SettingsPage();
            }
            break;
          default:
            index = 0;
            if (_bodies[index] is! ComicsPage) {
              _bodies[index] = ComicsPage();
            }
            break;
        }
        return Scaffold(
          body: IndexedStack(
            index: index,
            children: _bodies,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_library),
                title: Text('Comics'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                title: Text('Sources'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_download),
                title: Text('Downloads'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
            currentIndex: index,
            onTap: (index) {
              switch (index) {
                case 1:
                  bloc.dispatch(HomeEvent(HomeEventType.showSourcesPage));
                  break;
                case 2:
                  bloc.dispatch(HomeEvent(HomeEventType.showDownloadsPage));
                  break;
                case 3:
                  bloc.dispatch(HomeEvent(HomeEventType.showSettingsPage));
                  break;
                default:
                  bloc.dispatch(HomeEvent(HomeEventType.showComicsPage));
                  break;
              }
            },
          ),
        );
      },
    );
  }
}

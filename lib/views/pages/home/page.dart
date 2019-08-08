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
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  HomeBloc bloc;
  List<Widget> _bodies;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
    _bodies = List.filled(4, Container());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) {
        if (_bodies[state.index] is Container) {
          switch (state.index) {
            case 0:
              _bodies[state.index] = ComicsPage();
              break;
            case 1:
              _bodies[state.index] = SourcesPage();
              break;
            case 2:
              _bodies[state.index] = DownloadsPage();
              break;
            case 3:
              _bodies[state.index] = SettingsPage();
              break;
            default:
              break;
          }
        }
        return Scaffold(
          body: IndexedStack(
            index: state.index,
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
            currentIndex: state.index,
            onTap: (index) {
              bloc.dispatch(HomeEvent(HomeEventType.display, index: index));
            },
          ),
        );
      },
    );
  }
}

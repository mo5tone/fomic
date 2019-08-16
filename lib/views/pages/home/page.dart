import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/home/bloc.dart';
import 'package:fomic/blocs/home/event.dart';
import 'package:fomic/blocs/home/state.dart';
import 'package:fomic/views/pages/download/page.dart';
import 'package:fomic/views/pages/explore/page.dart';
import 'package:fomic/views/pages/favorite//page.dart';
import 'package:fomic/views/pages/settings/page.dart';

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
              _bodies[state.index] = FavoritePage();
              break;
            case 1:
              _bodies[state.index] = ExplorePage();
              break;
            case 2:
              _bodies[state.index] = DownloadPage();
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
                icon: Icon(Icons.favorite),
                title: Text('Favorite'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                title: Text('Explore'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_download),
                title: Text('Download'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
            currentIndex: state.index,
            onTap: (index) {
              bloc.dispatch(HomeEvent.display(index: index));
            },
          ),
        );
      },
    );
  }
}

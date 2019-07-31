import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/comics/screen.dart';
import 'package:fomic/download/screen.dart';
import 'package:fomic/favorite/screen.dart';
import 'package:fomic/home/bloc.dart';
import 'package:fomic/home/event.dart';
import 'package:fomic/home/state.dart';
import 'package:fomic/setting/screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => HomeBloc(),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  final List<Widget> _bodies = List<Widget>.filled(4, Container());

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (_bodies[state.index] is Container) {
          switch (state.index) {
            case 1:
              _bodies[state.index] = FavoriteScreen();
              break;
            case 2:
              _bodies[state.index] = DownloadScreen();
              break;
            case 3:
              _bodies[state.index] = SettingScreen();
              break;
            default:
              _bodies[state.index] = ComicsScreen();
              break;
          }
        }
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: _bodies,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_library),
                title: Text('Comics'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favorite'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_download),
                title: Text('Download'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Setting'),
              ),
            ],
            onTap: (index) => bloc.dispatch(HomeEvent.index(index)),
            currentIndex: state.index,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/comics/screen.dart';
import 'package:fomic/download/bloc.dart';
import 'package:fomic/download/screen.dart';
import 'package:fomic/favorite/bloc.dart';
import 'package:fomic/favorite/screen.dart';
import 'package:fomic/home/state.dart';
import 'package:fomic/setting/bloc.dart';
import 'package:fomic/setting/screen.dart';

import 'bloc.dart';
import 'event.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder(
      builder: (context, HomeState state) {
        Widget body;
        switch (state.index) {
          case 1:
            body = BlocProvider(
              builder: (context) => FavoriteBloc(),
              child: FavoriteScreen(),
            );
            break;
          case 2:
            body = BlocProvider(
              builder: (context) => DownloadBloc(),
              child: DownloadScreen(),
            );
            break;
          case 3:
            body = BlocProvider(
              builder: (context) => SettingBloc(),
              child: SettingScreen(),
            );
            break;
          default:
            body = ComicsScreen();
            break;
        }
        return Scaffold(
          body: body,
          bottomNavigationBar: BottomNavigationBar(
            items: [
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
      bloc: bloc,
    );
  }
}

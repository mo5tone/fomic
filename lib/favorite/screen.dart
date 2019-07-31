import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/favorite/bloc.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => FavoriteBloc(),
      child: _FavoritePage(),
    );
  }
}

class _FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.runtimeType}'),
      ),
      body: Text('${this.runtimeType}'),
    );
  }
}

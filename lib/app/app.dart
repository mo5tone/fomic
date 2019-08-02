import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/app/bloc.dart';
import 'package:fomic/app/state.dart';
import 'package:fomic/home/screen.dart';

class Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => FomicBloc(),
      child: _Fomic(),
    );
  }
}

class _Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FomicBloc, FomicState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Fomic',
          theme: ThemeData(
            brightness: state.darkMode ? Brightness.dark : Brightness.light,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}

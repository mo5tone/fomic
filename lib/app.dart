import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/home/bloc.dart';
import 'package:fomic/home/screen.dart';

class Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider(
        builder: (context) => HomeBloc(),
        child: HomeScreen(),
      ),
    );
  }
}

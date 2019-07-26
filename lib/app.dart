import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/comics/bloc/bloc.dart';
import 'package:fomic/comics/bloc/event.dart';
import 'package:fomic/comics/repository/repository.dart';
import 'package:fomic/comics/widget/screen.dart';

class Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: BlocProvider(
        builder: (context) =>
            ComicsBloc(ComicsRepository())..dispatch(ComicsEventRefresh()),
        child: ComicsScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comics//bloc.dart';
import 'comics/event.dart';
import 'comics/repository.dart';
import 'comics/screen.dart';

class Fomic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomic',
      theme: ThemeData(primaryColor: Colors.blue),
      home: BlocProvider(
        builder: (context) =>
            ComicsBloc(ComicsRepository())..dispatch(ComicsEventRefresh()),
        child: ComicsScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/setting/bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => SettingBloc(),
      child: _SettingPage(),
    );
  }
}

class _SettingPage extends StatelessWidget {
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

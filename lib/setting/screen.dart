import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/app/bloc.dart';
import 'package:fomic/app/event.dart';
import 'package:fomic/setting/bloc.dart';
import 'package:fomic/setting/state.dart';

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
        title: Text('Setting'),
      ),
      body: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  final fomicBloc = BlocProvider.of<FomicBloc>(context);
                  fomicBloc.dispatch(FomicEvent());
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

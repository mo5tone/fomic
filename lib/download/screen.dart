import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/download/bloc.dart';

class DownloadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => DownloadBloc(),
      child: _DownloadPage(),
    );
  }
}

class _DownloadPage extends StatelessWidget {
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

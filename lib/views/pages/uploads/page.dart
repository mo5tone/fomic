import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fomic/blocs/uploads/bloc.dart';
import 'package:fomic/blocs/uploads/state.dart';
import 'package:fomic/common/util/routes.dart';

class UploadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => UploadsBloc(),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadsBloc, UploadsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // todo: check mini server is running and close it.
                Navigator.of(context).maybePop();
              },
            ),
            title: Text.rich(
              TextSpan(
                text: 'Uploads',
                style: Theme.of(context).textTheme.title,
                children: [
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'IP Address: 127.0.0.1',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  Routes.navigateTo(context, '/hello');
                  // todo: start or end mini server.
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Container(),
          ),
        );
      },
    );
  }
}

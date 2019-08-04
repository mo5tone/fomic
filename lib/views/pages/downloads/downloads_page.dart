import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.runtimeType}'),
      ),
      body: Container(
        child: Center(
          child: Text('${this.runtimeType}'),
        ),
      ),
    );
  }
}

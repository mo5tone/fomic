import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
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

import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.black54,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        onWillPop: () => Future.value(false),
      ),
    );
  }
}

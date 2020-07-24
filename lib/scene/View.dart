import 'package:flutter/material.dart';
import 'package:fomic/scene/ViewModel.dart';
import 'package:fomic/utils/Dialogs.dart';

abstract class View<VM extends ViewModel> extends StatelessWidget {
  final _loadingDialogKey = GlobalKey<State>();

  final VM viewmodel;

  View({Key key, this.viewmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewmodel.loading.addListener(() {
      if (viewmodel.loading.value) {
        Dialogs.showLoadingDialog(context, _loadingDialogKey);
      } else {
        Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true).pop();
      }
    });
    viewmodel.error.addListener(() {
      final error = viewmodel.error.value;
      if (error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    });
    return Container();
  }
}

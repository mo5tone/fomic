import 'package:flutter/material.dart';
import 'package:fomic/scene/ViewModel.dart';
import 'package:fomic/utils/Dialogs.dart';
import 'package:provider/provider.dart';

class ListenableWidget<VM extends ViewModel> extends StatefulWidget {
  final Widget child;

  const ListenableWidget({Key key, this.child}) : super(key: key);

  @override
  ListenableWidgetState createState() => ListenableWidgetState<VM>();
}

class ListenableWidgetState<VM extends ViewModel> extends State<ListenableWidget> {
  final _loadingKey = GlobalKey<ListenableWidgetState<VM>>();

  @override
  Widget build(BuildContext context) {
    return Consumer<VM>(
      builder: (ctx, value, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final loading = value.loading;
          if (loading == true) {
            Dialogs.showLoadingDialog(ctx, _loadingKey);
          } else if (loading == false) {
            Navigator.of(_loadingKey.currentContext, rootNavigator: true).pop();
          }
          final message = value.message;
          if (message != null && message.isNotEmpty) {
            Scaffold.of(ctx)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          }
        });
        return child;
      },
      child: widget.child,
    );
  }
}

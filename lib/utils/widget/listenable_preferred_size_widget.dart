import 'package:flutter/material.dart';
import 'package:fomic/scene/view_model.dart';
import 'package:fomic/utils/widget/listenable_widget.dart';

class ListenablePreferredSizeWidget<VM extends ViewModel> extends ListenableWidget implements PreferredSizeWidget {
  @override
  final PreferredSizeWidget child;

  const ListenablePreferredSizeWidget({Key key, this.child}) : super(key: key, child: child);

  @override
  ListenableWidgetState createState() => ListenableWidgetState<VM>();

  @override
  Size get preferredSize => child.preferredSize;
}

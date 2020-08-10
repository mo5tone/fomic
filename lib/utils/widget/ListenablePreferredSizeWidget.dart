import 'package:flutter/material.dart';
import 'package:fomic/scene/ViewModel.dart';
import 'package:fomic/utils/widget/ListenableWidget.dart';

class ListenablePreferredSizeWidget<VM extends ViewModel> extends ListenableWidget implements PreferredSizeWidget {
  @override
  final PreferredSizeWidget child;

  const ListenablePreferredSizeWidget({Key key, this.child}) : super(key: key, child: child);

  @override
  ListenableWidgetState createState() => ListenableWidgetState<VM>();

  @override
  Size get preferredSize => child.preferredSize;
}

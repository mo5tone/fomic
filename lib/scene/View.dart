import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:fomic/scene/view_model.dart';

abstract class View<VM extends ViewModel, SW extends StatefulWidget> extends State<SW> {
  @protected
  VM vm;

  void _handleLoading() {
    if (vm.loading) {
      EasyLoading.show();
    } else {
      EasyLoading.dismiss();
    }
  }

  void _handleMessage() {
    if (vm.message != null && vm.message.isNotEmpty) EasyLoading.showToast(vm.message);
  }

  @override
  void initState() {
    super.initState();
    vm = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleLoading();
      _handleMessage();
      vm.setLoadingListener(_handleLoading);
      vm.setMessageListener(_handleMessage);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:fomic/scene/view_model.dart';

abstract class View<VM extends ViewModel, W extends StatefulWidget> extends State<W> {
  @protected
  VM vm;

  @override
  void initState() {
    super.initState();
    vm = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.setLoadingListener(() {
        if (vm.loading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
      });
      vm.setMessageListener(() {
        if (vm.message != null && vm.message.isNotEmpty) EasyLoading.showToast(vm.message);
      });
    });
  }
}

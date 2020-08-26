import 'package:flutter/material.dart';

import 'package:fomic/model/constant/app.i18n.dart';
import 'package:fomic/scene/setting/view_model/setting_view_model.dart';
import 'package:fomic/scene/view.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends View<SettingViewModel, SettingView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'.i18n),
      ),
    );
  }
}

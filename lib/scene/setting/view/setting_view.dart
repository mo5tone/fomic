import 'package:flutter/material.dart';
import 'package:fomic/model/constant/app.i18n.dart';
import 'package:fomic/scene/setting/view_model/brightness_change_notifier.dart';
import 'package:fomic/scene/setting/view_model/setting_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<SettingViewModel, SettingView> with AutomaticKeepAliveClientMixin {
  Future<Brightness> showBrightnessBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (ctx) {
          final brightness = ctx.select((BrightnessChangeNotifier value) => value.brightness);
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.brightness_5),
                    trailing: brightness == Brightness.light ? Icon(Icons.check) : null,
                    title: Text('Light'),
                    onTap: () => Navigator.of(ctx).pop(Brightness.light),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.brightness_4),
                    trailing: brightness == Brightness.dark ? Icon(Icons.check) : null,
                    title: Text('Dark'),
                    onTap: () => Navigator.of(ctx).pop(Brightness.dark),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.brightness_auto),
                    trailing: brightness == null ? Icon(Icons.check) : null,
                    title: Text('System'),
                    onTap: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Widget item;
    switch (index) {
      case 0:
        item = ListTile(
          leading: Icon(Icons.brightness_medium),
          title: Text('Brightness'),
          onTap: () => showBrightnessBottomSheet(context).then((value) {
            final changeNotifier = context.read<BrightnessChangeNotifier>();
            changeNotifier.brightness = value;
          }),
        );
    }
    return item;
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return Divider();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'.i18n),
      ),
      body: ListView.separated(
        itemBuilder: _itemBuilder,
        separatorBuilder: _separatorBuilder,
        itemCount: 1,
      ),
    );
  }
}

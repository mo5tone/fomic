import 'package:flutter/material.dart';
import 'package:fomic/model/constant/app.i18n.dart';
import 'package:fomic/scene/setting/view_model/theme_change_notifier.dart';
import 'package:fomic/scene/setting/view_model/setting_view_model.dart';
import 'package:fomic/scene/view.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  @override
  _View createState() => _View();
}

class _View extends View<SettingViewModel, SettingView> with AutomaticKeepAliveClientMixin {
  Future<Brightness> _showBrightnessBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (ctx) {
        final brightness = ctx.select((ThemeChangeNotifier value) => value.brightness);
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
      },
    );
  }

  Future<ColorSwatch> _showColorBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final primarySwatch = ctx.select((ThemeChangeNotifier value) => value.primarySwatch);
        final itemCount = vm.colors.length;
        final column = 5;
        final row = (itemCount.toDouble() / column).ceil();
        final spacing = 8.0;
        final screenWidth = MediaQuery.of(ctx).size.width;
        final itemWidth = (screenWidth - spacing * 2 - spacing * (column - 1)) / column;
        final containerHeight = row * itemWidth + (row - 1) * spacing + spacing * 2;
        return SafeArea(
          child: Container(
            height: containerHeight,
            margin: EdgeInsets.all(spacing),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: column,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
              ),
              itemBuilder: (ctx, idx) {
                final color = vm.colors[idx];
                return InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.all(Radius.circular(itemWidth / 2)),
                    ),
                    child: primarySwatch == color
                        ? Icon(
                            Icons.check,
                            color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
                          )
                        : null,
                  ),
                  onTap: () => Navigator.of(ctx).pop(color),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Widget item;
    switch (index) {
      case 0:
        item = ListTile(
          leading: Icon(Icons.brightness_medium),
          title: Text('Brightness'),
          onTap: () => _showBrightnessBottomSheet(context).then((value) {
            final changeNotifier = context.read<ThemeChangeNotifier>();
            changeNotifier.brightness = value;
          }),
        );
        break;
      case 1:
        item = ListTile(
          leading: Icon(Icons.color_lens),
          title: Text('Color'),
          onTap: () => _showColorBottomSheet(context).then((value) {
            final changeNotifier = context.read<ThemeChangeNotifier>();
            changeNotifier.primarySwatch = value;
          }),
        );
        break;
    }
    return item;
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
        separatorBuilder: (_, idx) => Divider(),
        itemCount: 2,
      ),
    );
  }
}

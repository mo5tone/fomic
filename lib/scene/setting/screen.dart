import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/state/theme_state.dart';
import 'package:fomic/model/constant/constant.dart';

class SettingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Widget item;
          switch (index) {
            case 0:
              item = ListTile(
                leading: Icon(Icons.brightness_medium),
                title: Text('Brightness'),
                onTap: () => showModalBottomSheet<Brightness>(
                  context: context,
                  isDismissible: false,
                  builder: (context) => _BrightnessBottomSheet(),
                ).then((value) {
                  context.read(rpThemeStateNotifier).brightness = value;
                }),
              );
              break;
            case 1:
              item = ListTile(
                leading: Icon(Icons.color_lens),
                title: Text('Color'),
                onTap: () => showModalBottomSheet<ColorSwatch>(
                  context: context,
                  builder: (context) => _PrimarySwatchBottomSheet(),
                ).then((value) {
                  context.read(rpThemeStateNotifier).primarySwatch = value;
                }),
              );
              break;
          }
          return item;
        },
        separatorBuilder: (_, __) => Divider(),
        itemCount: 2,
      ),
    );
  }
}

class _BrightnessBottomSheet extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = useProvider(rpThemeStateNotifier.state.select((value) => value.brightness));
    return SafeArea(
      child: Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.brightness_5),
              trailing: brightness == Brightness.light ? Icon(Icons.check) : null,
              title: Text('Light'),
              onTap: () => Navigator.of(context).pop(Brightness.light),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_4),
              trailing: brightness == Brightness.dark ? Icon(Icons.check) : null,
              title: Text('Dark'),
              onTap: () => Navigator.of(context).pop(Brightness.dark),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_auto),
              trailing: brightness == null ? Icon(Icons.check) : null,
              title: Text('System'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimarySwatchBottomSheet extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final primarySwatch = useProvider(rpThemeStateNotifier.state.select((value) => value.primarySwatch));
    final itemCount = primarySwatches.length;
    final column = 5;
    final row = (itemCount.toDouble() / column).ceil();
    final spacing = 8.0;
    final screenWidth = MediaQuery.of(context).size.width;
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
            final color = primarySwatches[idx];
            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(itemWidth / 2)),
                ),
                child: primarySwatch == color
                    ? Icon(
                        Icons.check,
                        color: ColorScheme.fromSwatch(
                          primarySwatch: color,
                        ).onPrimary,
                      )
                    : null,
              ),
              onTap: () => Navigator.of(ctx).pop(color),
            );
          },
        ),
      ),
    );
  }
}

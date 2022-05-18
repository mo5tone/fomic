import 'package:flutter/material.dart';
import 'package:fomic/feature/setting/theme_bloc.dart';
import 'package:fomic/l10n/l10n.dart';
import 'package:fomic/model/primary_swatch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingView extends HookConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeBLoC = ref.watch(ThemeBLoC.provider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(L10N.of(context).setting),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        itemCount: 3,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (context, index) {
          Widget item;
          switch (index) {
            case 0:
              item = ListTile(
                leading: const Icon(Icons.flutter_dash),
                title: Text(L10N.of(context).brightnessModes),
                trailing: Switch(
                  value: ref.watch(ThemeBLoC.provider).useMaterial3,
                  onChanged: (value) => themeBLoC.add(ThemeEvent.useMaterial3(value)),
                ),
              );
              break;
            case 1:
              item = ListTile(
                leading: const Icon(Icons.brightness_medium),
                title: Text(L10N.of(context).brightnessModes),
                trailing: Icon(ref.watch(ThemeBLoC.provider).brightness?.iconData ?? Icons.brightness_auto),
                onTap: () => showModalBottomSheet<Brightness>(
                  context: context,
                  isDismissible: false,
                  builder: (context) => _BrightnessBottomSheet(),
                ).then((value) {
                  themeBLoC.add(ThemeEvent.brightness(value));
                }),
              );
              break;
            case 2:
              item = ListTile(
                leading: const Icon(Icons.color_lens),
                title: Text(L10N.of(context).primarySwatchColor),
                trailing: Container(
                  width: 20,
                  height: 20,
                  color: ref.watch(ThemeBLoC.provider).primarySwatch,
                ),
                onTap: () => showModalBottomSheet<MaterialColor>(
                  context: context,
                  builder: (context) => _PrimarySwatchBottomSheet(),
                ).then((value) {
                  if (value != null) {
                    themeBLoC.add(ThemeEvent.primarySwatch(value));
                  }
                }),
              );
              break;
            default:
              item = Container();
              break;
          }
          return item;
        },
      ),
    );
  }
}

class _BrightnessBottomSheet extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(ThemeBLoC.provider.select((value) => value.brightness));
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_5),
            trailing: brightness == Brightness.light ? const Icon(Icons.check) : null,
            title: Text(L10N.of(context).lightMode),
            onTap: () => Navigator.of(context).pop(Brightness.light),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_4),
            trailing: brightness == Brightness.dark ? const Icon(Icons.check) : null,
            title: Text(L10N.of(context).darkMode),
            onTap: () => Navigator.of(context).pop(Brightness.dark),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_auto),
            trailing: brightness == null ? const Icon(Icons.check) : null,
            title: Text(L10N.of(context).followSystem),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _PrimarySwatchBottomSheet extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primarySwatch = ref.watch(ThemeBLoC.provider.select((value) => value.primarySwatch));
    final itemCount = PrimarySwatch.values.length;
    const column = 5;
    final row = (itemCount.toDouble() / column).ceil();
    const spacing = 8.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - spacing * 2 - spacing * (column - 1)) / column;
    final containerHeight = row * itemWidth + (row - 1) * spacing + spacing * 2;
    return SafeArea(
      child: Container(
        height: containerHeight,
        margin: const EdgeInsets.all(spacing),
        child: Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: PrimarySwatch.values.map((swatch) {
            final color = swatch.color;
            return InkWell(
              child: Container(
                width: itemWidth,
                height: itemWidth,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(itemWidth / 2)),
                ),
                child: primarySwatch == color
                    ? Icon(
                        Icons.check,
                        color: ColorScheme.fromSwatch(primarySwatch: color).onPrimary,
                      )
                    : null,
              ),
              onTap: () => Navigator.of(context).pop(color),
            );
          }).toList(),
        ),
      ),
    );
  }
}

extension on Brightness {
  IconData get iconData {
    switch (this) {
      case Brightness.dark:
        return Icons.brightness_4;
      case Brightness.light:
        return Icons.brightness_5;
    }
  }
}

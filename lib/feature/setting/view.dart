import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/bloc/theme_bloc.dart';
import 'package:fomic/repository/service/theme_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingView extends HookConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeBLoC = ref.read(ThemeBLoC.provider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.setting),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Widget item;
          if (index == 0) {
            item = ListTile(
              leading: const Icon(Icons.brightness_medium),
              title: Text(AppLocalizations.of(context)!.brightnessModes),
              onTap: () => showModalBottomSheet<Brightness>(
                context: context,
                isDismissible: false,
                builder: (context) => _BrightnessBottomSheet(),
              ).then((value) {
                themeBLoC.add(ThemeEvent.brightness(value));
              }),
            );
          } else {
            item = ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(AppLocalizations.of(context)!.primarySwatchColor),
              onTap: () => showModalBottomSheet<MaterialColor>(
                context: context,
                builder: (context) => _PrimarySwatchBottomSheet(),
              ).then((value) {
                if (value != null) {
                  themeBLoC.add(ThemeEvent.primarySwatch(value));
                }
              }),
            );
          }
          return item;
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: 2,
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
            title: Text(AppLocalizations.of(context)!.lightMode),
            onTap: () => Navigator.of(context).pop(Brightness.light),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_4),
            trailing: brightness == Brightness.dark ? const Icon(Icons.check) : null,
            title: Text(AppLocalizations.of(context)!.darkMode),
            onTap: () => Navigator.of(context).pop(Brightness.dark),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_auto),
            trailing: brightness == null ? const Icon(Icons.check) : null,
            title: Text(AppLocalizations.of(context)!.followSystem),
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
    final itemCount = primarySwatches.length;
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
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        color: ColorScheme.fromSwatch(primarySwatch: color).onPrimary,
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

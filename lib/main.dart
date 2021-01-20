import 'package:flutter/material.dart';
import 'package:fomic/application.dart';
import 'package:fomic/source/model/book.dart';
import 'package:fomic/source/model/chapter.dart';
import 'package:fomic/source/model/page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  final adapters = [BookAdapter(), ChapterAdapter(), PageAdapter()];
  adapters.forEach((adapter) => Hive.registerAdapter(adapter));
  final providerScope = ProviderScope(
    child: Fomic(),
  );
  runApp(providerScope);
}

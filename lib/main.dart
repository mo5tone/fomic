import 'package:flutter/material.dart';
import 'package:fomic/application.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const ProviderScope(child: Fomic()));
}

import 'package:flutter/material.dart';
import 'package:fomic/application.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: Fomic()));
}

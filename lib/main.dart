import 'package:flutter/material.dart';
import 'package:fomic/application.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  ErrorWidget.builder = (details) {
    return Material(
      child: Container(
        color: Colors.redAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.exception.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (details.stack != null)
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                child: Text(
                  details.stack.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  };
  await Hive.initFlutter();
  runApp(const ProviderScope(child: Fomic()));
}

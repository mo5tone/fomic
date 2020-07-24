import 'package:flutter/material.dart';

class ViewModel with ChangeNotifier {
  final loading = ValueNotifier(false);
  final error = ValueNotifier<dynamic>(null);
}

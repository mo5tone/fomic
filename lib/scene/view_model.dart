import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewModel with ChangeNotifier {
  bool _loading;
  String _message;

  bool get loading => _loading;
  String get message => _message;

  @protected
  set loading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  @protected
  set message(String value) {
    if (value != null && value.isNotEmpty && value != _message) {
      _message = value;
      notifyListeners();
    }
  }
}

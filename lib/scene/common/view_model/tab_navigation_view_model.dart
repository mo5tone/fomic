import 'package:flutter/material.dart';
import 'package:fomic/scene/view_model.dart';

class TabNavigationViewModel extends ViewModel {
  var _currentIndex = 0;
  final _reTappedIndex = ValueNotifier(-1);

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    if (value != _currentIndex) {
      _currentIndex = value;
      notifyListeners();
    }
  }

  int get reTappedIndex => _reTappedIndex.value;

  set reTappedIndex(int value) {
    if (value != _reTappedIndex.value) {
      _reTappedIndex.value = value;
    }
  }

  void addReTappedIndexListener(void Function() listener) {
    _reTappedIndex.addListener(listener);
  }

  @override
  void dispose() {
    _reTappedIndex.dispose();
    super.dispose();
  }
}

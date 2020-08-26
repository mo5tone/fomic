import 'package:fomic/scene/view_model.dart';

class BottomNavigationViewModel extends ViewModel {
  var _currentIndex = 0;
  int _reTappedIndex;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    if (value != _currentIndex) {
      _currentIndex = value;
      notifyListeners();
    }
  }

  int get reTappedIndex => _reTappedIndex;

  set reTappedIndex(int value) {
    if (value != _reTappedIndex) {
      _reTappedIndex = value;
      if (value != null) {
        notifyListeners();
      }
    }
  }
}

class Pair<T0, T1> {
  T0 _first;
  T1 _second;

  Pair(T0 first, T1 second)
      : _first = first,
        _second = second;

  operator [](int index) {
    assert(index == 0 || index == 1);
    return index == 0 ? _first : _second;
  }

  operator []=(int index, value) {
    assert(index == 0 || index == 1);
    if (index == 0 && value is T0) {
      _first = value;
    } else if (index == 1 && value is T1) {
      _second = value;
    }
  }
}

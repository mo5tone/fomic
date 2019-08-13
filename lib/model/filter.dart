import 'package:fomic/common/helper/pair.dart';

abstract class Filter<State> {
  final String name;
  State state;

  Filter(this.name, {this.state})
      : assert(name != null && name.isNotEmpty),
        assert(state != null);

  void reset();

  get option => null;
}

abstract class SwitchableFilter extends Filter<bool> {
  SwitchableFilter(String name, {bool state = false})
      : super(name, state: state);

  @override
  void reset() {
    state = false;
  }
}

abstract class SelectableFilter<Value> extends Filter<int> {
  final List<Pair<String, Value>> options;

  SelectableFilter(String name, this.options, {int state = 0})
      : assert(options != null && options.isNotEmpty),
        super(name, state: state);

  @override
  void reset() {
    state = 0;
  }

  @override
  Pair<String, Value> get option => options[state];

  get alias;

  get value;

  List<String> get aliases;
}

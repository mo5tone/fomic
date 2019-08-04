abstract class Filter<State> {
  final String name;
  State state;

  Filter(this.name, {this.state})
      : assert(name != null && name.isNotEmpty),
        assert(state != null);

  get value => null;
}

abstract class SwitchableFilter extends Filter<bool> {
  SwitchableFilter(String name, {bool state = false})
      : super(name, state: state);
}

abstract class SelectableFilter<E> extends Filter<int> {
  final List<E> options;

  SelectableFilter(String name, this.options, {int state = 0})
      : assert(options != null && options.isNotEmpty),
        super(name, state: state);

  @override
  get value => options[state];
}

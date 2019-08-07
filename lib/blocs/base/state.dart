import 'package:fomic/common/helper/cloneable.dart';

abstract class State<Type> implements Comparable, Cloneable {
  final Type type;

  State(this.type) : assert(type != null);

  /// used like `current.compareTo(previous)`
  /// 0x00: Nothing to do
  /// 0x01: Widget builder(ctx, state)
  /// 0x10: void listener(ctx, state)
  @override
  int compareTo(other) => 0x11;

  @override
  String toString() {
    return '$type';
  }
}

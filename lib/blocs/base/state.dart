import 'package:fomic/common/helper/cloneable.dart';

abstract class State<Type> implements Cloneable {
  final Type type;

  State(this.type) : assert(type != null);

  @override
  String toString() {
    return '$type';
  }
}

abstract class Event<Type> {
  final Type type;

  Event(this.type) : assert(type != null);

  @override
  String toString() {
    return '$type';
  }
}
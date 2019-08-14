import 'package:fomic/blocs/base/state.dart' as base;

enum UploadsStateType {
  placeholder,
}

class UploadsState extends base.State<UploadsStateType> {
  final bool running;

  UploadsState(
    UploadsStateType type, {
    this.running = false,
  }) : super(type);

  @override
  clone() {
    // TODO: implement clone
    return null;
  }
}

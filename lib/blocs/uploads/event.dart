import 'package:fomic/blocs/base/event.dart' as base;

enum UploadsEventType {
  start,
  end,
}

class UploadsEvent extends base.Event<UploadsEventType> {
  UploadsEvent(UploadsEventType type) : super(type);
}

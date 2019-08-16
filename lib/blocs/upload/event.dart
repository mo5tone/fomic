import 'package:fomic/blocs/base/event.dart' as base;

class UploadsEvent extends base.Event {
  UploadsEvent._();

  factory UploadsEvent.startServer() {
    return UploadsEventStartServer._();
  }

  factory UploadsEvent.stopServer() {
    return UploadsEventStopServer._();
  }
}

class UploadsEventStartServer extends UploadsEvent {
  UploadsEventStartServer._() : super._();
}

class UploadsEventStopServer extends UploadsEvent {
  UploadsEventStopServer._() : super._();
}

import 'package:fomic/blocs/base/event.dart' as base;

enum HomeEventType {
  showComicsPage,
  showSourcesPage,
  showDownloadsPage,
  showSettingsPage,
}

class HomeEvent extends base.Event<HomeEventType> {
  HomeEvent(HomeEventType type) : super(type);
}

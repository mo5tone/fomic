enum HomeEventType {
  showComicsPage,
  showSourcesPage,
  showDownloadsPage,
  showSettingsPage,
}

class HomeEvent {
  final HomeEventType type;

  HomeEvent(this.type) : assert(type != null);
}

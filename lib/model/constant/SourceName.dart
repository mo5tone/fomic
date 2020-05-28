enum SourceName {
  dmzj,
}

extension Extension on SourceName {
  String get title {
    switch (this) {
      case SourceName.dmzj:
        return '动漫之家';
      default:
        return null;
    }
  }
}

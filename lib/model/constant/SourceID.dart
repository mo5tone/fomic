enum SourceID {
  dmzj,
}

extension Extension on SourceID {
  String get name {
    switch (this) {
      case SourceID.dmzj:
        return '动漫之家';
      default:
        return null;
    }
  }
}

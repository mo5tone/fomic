enum SourceId {
  dmzj,
  bnmanhua,
}

extension SourceIdEx on SourceId {
  String get name {
    switch (this) {
      case SourceId.dmzj:
        return '动漫之家';
      case SourceId.bnmanhua:
        return '百年漫画';
      default:
        return null;
    }
  }
}

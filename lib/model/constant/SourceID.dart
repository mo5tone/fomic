enum SourceID {
  dmzj,
  bnmanhua,
}

extension SourceIDEx on SourceID {
  String get name {
    switch (this) {
      case SourceID.dmzj:
        return '动漫之家';
      case SourceID.bnmanhua:
        return '百年漫画';
      default:
        return null;
    }
  }
}

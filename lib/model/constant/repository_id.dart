enum RepositoryID {
  dmzj,
  bnmanhua,
}

extension RepositoryIDEx on RepositoryID {
  String get name {
    switch (this) {
      case RepositoryID.dmzj:
        return '动漫之家';
      case RepositoryID.bnmanhua:
        return '百年漫画';
      default:
        return null;
    }
  }
}

enum RepositoryName {
  dmzj,
}

extension Title on RepositoryName {
  String get title {
    switch (this) {
      case RepositoryName.dmzj:
        return '动漫之家';
      default:
        return null;
    }
  }
}

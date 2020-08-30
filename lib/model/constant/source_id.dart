enum SourceID {
  local,
  dmzj,
  bnManHua,
}

extension SourceIDEx on SourceID {
  String get name {
    var name = 'Source';
    switch (this) {
      case SourceID.local:
        name = 'Local';
        break;
      case SourceID.dmzj:
        name = '动漫之家';
        break;
      case SourceID.bnManHua:
        name = '百年漫画';
        break;
    }
    return name;
  }

  String get languageCode {
    var code = 'en';
    switch (this) {
      case SourceID.local:
        code = 'en';
        break;
      case SourceID.dmzj:
        code = 'zh';
        break;
      case SourceID.bnManHua:
        code = 'zh';
        break;
    }
    return code;
  }
}

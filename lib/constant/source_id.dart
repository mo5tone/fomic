import 'package:hooks_riverpod/hooks_riverpod.dart';

final rpSourceId = StateProvider((ref) => SourceId.values.first);

enum SourceId {
  local,
  dmzj,
  bnManHua,
}

extension SourceIdX on SourceId {
  String get name {
    var name = 'Source';
    switch (this) {
      case SourceId.local:
        name = 'Local';
        break;
      case SourceId.dmzj:
        name = '动漫之家';
        break;
      case SourceId.bnManHua:
        name = '百年漫画';
        break;
    }
    return name;
  }

  String get languageCode {
    var code = 'en';
    switch (this) {
      case SourceId.local:
        code = 'en';
        break;
      case SourceId.dmzj:
        code = 'zh';
        break;
      case SourceId.bnManHua:
        code = 'zh';
        break;
    }
    return code;
  }
}

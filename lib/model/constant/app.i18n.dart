import 'package:i18n_extension/i18n_extension.dart';

extension Translation on String {
  static const Map<String, String> _en = {
    'Keyword': 'Keyword',
    'Unknown': 'Unknown',
    'Ongoing': 'Ongoing',
    'Completed': 'Completed',
    'Licensed': 'Licensed',
  };

  static const Map<String, String> _zh = {
    'Keyword': '关键字',
    'Unknown': '未知',
    'Ongoing': '连载中',
    'Completed': '已完结',
    'Licensed': '未许可',
  };

  static final _translations = Translations.byLocale('en') + {'en': _en, 'zh': _zh};

  String get i18n => localize(this, _translations);
}

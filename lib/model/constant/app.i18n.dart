import 'package:i18n_extension/i18n_extension.dart';

extension I18n on String {
  static const Map<String, String> _en = {
    'Keyword': 'Keyword',
    'Unknown': 'Unknown',
    'Ongoing': 'Ongoing',
    'Completed': 'Completed',
    'Licensed': 'Licensed',
    'Explore': 'Explore',
    'Setting': 'Setting',
  };

  static const Map<String, String> _zh = {
    'Keyword': '关键字',
    'Unknown': '未知',
    'Ongoing': '连载中',
    'Completed': '已完结',
    'Licensed': '未许可',
    'Explore': '逛逛',
    'Setting': '设置',
  };

  static final _translations = Translations.byLocale('en') + {'en': _en, 'zh': _zh};

  String get i18n => localize(this, _translations);
  String plural(int value) => localizePlural(value, this, _translations);
}
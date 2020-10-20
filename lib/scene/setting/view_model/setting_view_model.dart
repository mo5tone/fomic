import 'package:fomic/scene/view_model.dart';
import 'package:fomic/utils/mixin/theme_change_mixin.dart';

class SettingViewModel extends ViewModel with ThemeChangeMixin {
  SettingViewModel() {
    initThemeChangeMixin();
  }
}

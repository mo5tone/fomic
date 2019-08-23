import 'package:fomic/sources/base/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValue {
  KeyValue._();

  static Future<bool> disableSource(SourceIdentity id) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool('${id}_is_available', false);
  }

  static Future<bool> enableSource(SourceIdentity id) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool('${id}_is_available', true);
  }

  static Future<bool> sourceIsAvailable(SourceIdentity id) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('${id}_is_available') ?? true;
  }
}

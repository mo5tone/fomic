import 'package:flutter/foundation.dart';

class ViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final _loading = ValueNotifier<bool>(false);
  final _message = ValueNotifier<String>(null);

  bool get loading => _loading.value;
  String get message => _message.value;

  @protected
  set loading(bool value) {
    print('loading: $value');
    _loading.value = value;
  }

  @protected
  set message(String value) {
    print('message: $value');
    _message.value = value;
    _message.value = null;
  }

  void setLoadingListener(void Function() listener) {
    if (!_loading.hasListeners) _loading.addListener(listener);
  }

  void setMessageListener(void Function() listener) {
    if (!_message.hasListeners) _message.addListener(listener);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('loading', value: loading, ifTrue: 'loading'));
    properties.add(StringProperty('message', message));
  }

  @override
  void dispose() {
    _loading.dispose();
    _message.dispose();
    super.dispose();
  }
}

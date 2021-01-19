import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rpHUDStateNotifier = StateNotifierProvider((ref) => HUDStateNotifier());

class HUDStateNotifier extends StateNotifier<HUDState> {
  HUDStateNotifier() : super(HUDState());

  set loading(bool value) {
    assert(value != null);
    state = HUDState(loading: value);
  }

  set message(String value) {
    assert(value != null || value.isNotEmpty);
    state = HUDState(message: value);
  }
}

class HUDState with EquatableMixin {
  final bool loading;
  final String message;

  HUDState({this.loading = false, this.message});

  @override
  List<Object> get props => [loading, message];
}

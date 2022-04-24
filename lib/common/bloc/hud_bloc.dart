import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'hud_bloc.freezed.dart';

@freezed
class HUDEvent with _$HUDEvent {
  const factory HUDEvent.toast(String message, {Duration? duration}) = HUDEventToast;
  const factory HUDEvent.show() = HUDEventShow;
  const factory HUDEvent.dismiss() = HUDEventDismiss;
}

@freezed
class HUDState with _$HUDState {
  const factory HUDState.toast(String message, {Duration? duration}) = HUDStateToast;
  const factory HUDState.loading() = HUDStateLoading;
  const factory HUDState.done() = HUDStateDone;
}

class HUDBLoC extends BLoC<HUDEvent, HUDState> {
  static final provider = StateNotifierProvider.autoDispose<HUDBLoC, HUDState>((ref) => HUDBLoC._());

  HUDBLoC._() : super(const HUDState.done());

  @override
  Stream<HUDState> mapEventToState(HUDEvent event) {
    return event.when(
      toast: (message, duration) async* {
        yield const HUDState.done();
        yield HUDState.toast(message, duration: duration);
      },
      show: () async* {
        yield const HUDState.done();
        yield const HUDState.loading();
      },
      dismiss: () async* {
        yield const HUDState.done();
      },
    );
  }
}

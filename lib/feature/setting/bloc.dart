import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class SettingEvent with _$SettingEvent {
  const factory SettingEvent.primarySwatch(MaterialColor primarySwatch) = SettingEventPrimarySwatch;
  const factory SettingEvent.brightness([Brightness? brightness]) = SettingEventBrightness;
}

@freezed
class SettingState with _$SettingState {
  const factory SettingState({required MaterialColor primarySwatch, Brightness? brightness}) = _SettingState;
}

class SettingBLoC extends BLoC<SettingEvent, SettingState> {
  static final provider = StateNotifierProvider.autoDispose((ref) => SettingBLoC._());

  SettingBLoC._() : super(const SettingState(primarySwatch: Colors.blue));

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) {
    return event.when(
      primarySwatch: (color) async* {
        yield state.copyWith(primarySwatch: color);
      },
      brightness: (brightness) async* {
        yield state.copyWith(brightness: brightness);
      },
    );
  }
}

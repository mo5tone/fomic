import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'whoops.freezed.dart';

@freezed
class Whoops with _$Whoops implements Exception {
  const factory Whoops.toast(String message, [@Default(Duration(seconds: 2)) Duration duration]) = WhoopsToast;
}

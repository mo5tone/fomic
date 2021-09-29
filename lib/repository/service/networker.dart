import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/bloc/hud_bloc.dart';

class Networker {
  static final family = Provider.autoDispose.family<Networker, BaseOptions>((ref, options) => Networker._(ref, options));

  final Dio _dio;
  final HUDBLoC _hudBLoC;

  Networker._(ProviderRefBase ref, BaseOptions baseOptions)
      : _dio = Dio(
          baseOptions
            ..connectTimeout = 5000
            ..receiveTimeout = 3000
            ..sendTimeout = 3000,
        )..interceptors.add(_LoadingIndicator(ref)),
        _hudBLoC = ref.read(HUDBLoC.provider.notifier);

  Future<T> fetch<T>(RequestOptions requestOptions, T Function(Response<dynamic>) parser) async {
    _hudBLoC.add(const HUDEvent.show());
    return _dio
        .fetch(requestOptions)
        .then(parser)
        .catchError((error, stackTrace) => _onError<T>(error, stackTrace))
        .whenComplete(() => _hudBLoC.add(const HUDEvent.dismiss()));
  }

  FutureOr<T> _onError<T>(dynamic error, StackTrace stackTrace) {
    debugPrint('Networker.fetch.error => $error');
    debugPrint('Networker.fetch.stackTrace => $stackTrace');
    _hudBLoC.add(HUDEvent.toast('$error'));
    throw error;
  }
}

class _LoadingIndicator extends Interceptor {
  final HUDBLoC _hudBLoc;

  _LoadingIndicator(ProviderRefBase ref) : _hudBLoc = ref.read(HUDBLoC.provider.notifier);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _hudBLoc.add(const HUDEvent.show());
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _hudBLoc.add(HUDEvent.toast(err.message));
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _hudBLoc.add(const HUDEvent.dismiss());
    super.onResponse(response, handler);
  }
}

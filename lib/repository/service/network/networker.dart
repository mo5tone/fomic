import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fomic/repository/service/network/interceptor/loading_indicator.dart';
import 'package:fomic/repository/service/request.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Networker {
  static final family = Provider.autoDispose.family<Networker, BaseOptions>((ref, options) => Networker._(ref, options));

  final Dio _dio;

  Networker._(Ref ref, BaseOptions baseOptions)
      : _dio = Dio(
          baseOptions
            ..connectTimeout = 5000
            ..receiveTimeout = 3000
            ..sendTimeout = 3000,
        )..interceptors.add(ref.read(LoadingIndicator.provider));

  Future<T> fetch<T>(Request req, {required T Function(Response<dynamic>) parser}) async {
    return _dio
        .request(
          req.path,
          data: req.data,
          queryParameters: req.queryParameters,
          cancelToken: req.cancelToken,
          options: req.options,
          onSendProgress: req.onSendProgress,
          onReceiveProgress: req.onReceiveProgress,
        )
        .then(parser)
        .catchError((error, stackTrace) => _onError<T>(error, stackTrace));
  }

  FutureOr<T> _onError<T>(dynamic error, StackTrace stackTrace) {
    debugPrint('Networker.fetch.error => $error');
    debugPrint('Networker.fetch.stackTrace => $stackTrace');
    throw error;
  }
}

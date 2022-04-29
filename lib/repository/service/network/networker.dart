import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'interceptor/loading_indicator.dart';
import 'request.dart';

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

  Future<T> fetch<T>(Request req, {required T Function(Response<dynamic>) parser}) {
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
        .then(parser);
  }
}

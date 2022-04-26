import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fomic/repository/service/network/interceptor/loading_indicator.dart';
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

  Future<T> fetch<T>(RequestOptions req, {required T Function(Response<dynamic>) parser}) {
    return _dio.fetch(req).then(parser).catchError((error, stackTrace) => _onError<T>(error, stackTrace));
  }

  FutureOr<T> _onError<T>(dynamic error, StackTrace stackTrace) {
    log('Networker#fetch failed', error: error, stackTrace: stackTrace);
    throw error;
  }
}

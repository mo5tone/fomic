import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fomic/repository/service/network/request.dart';

mixin Networker {
  Dio get dio;

  Future<T> fetch<T>(Request req, {required FutureOr<T> Function(Response<dynamic>) parser}) {
    return dio
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

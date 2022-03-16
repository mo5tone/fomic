import 'package:dio/dio.dart';

class Request {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final CancelToken? cancelToken;
  final Options? options;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;

  Request({required this.path, this.data, this.queryParameters, this.cancelToken, this.options, this.onSendProgress, this.onReceiveProgress});
}

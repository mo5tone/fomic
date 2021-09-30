import 'package:dio/dio.dart';

class Requisition {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final CancelToken? cancelToken;
  final Options? options;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;

  Requisition({required this.path, this.data, this.queryParameters, this.cancelToken, this.options, this.onSendProgress, this.onReceiveProgress});
}

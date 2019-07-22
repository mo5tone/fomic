import 'package:dio/dio.dart';

import 'remote_source.dart';

abstract class ApiSource extends RemoteSource {
  @override
  ResponseType get responseType => ResponseType.json;
}

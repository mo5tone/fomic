import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mime/mime.dart';

class DioFileServiceResponse implements FileServiceResponse {
  final _receivedTime = DateTime.now();
  final Response<List<int>> response;

  DioFileServiceResponse(this.response);

  @override
  Stream<List<int>> get content => Stream.value(response.data ?? []);

  @override
  int? get contentLength => response.data?.length;

  @override
  String? get eTag => response.headers.value('etag');

  @override
  String get fileExtension {
    var fileExtension = '';
    final contentType = response.headers.value(Headers.contentTypeHeader);
    if (contentType != null) {
      fileExtension = extensionFromMime(contentType);
    }
    return fileExtension;
  }

  @override
  int get statusCode => response.statusCode ?? 0;

  @override
  DateTime get validTill {
    // Without a cache-control header we keep the file for a week
    var ageDuration = const Duration(days: 7);
    final controlHeader = response.headers.value('cache-control');
    if (controlHeader != null) {
      final controlSettings = controlHeader.split(',');
      for (final setting in controlSettings) {
        final sanitizedSetting = setting.trim().toLowerCase();
        if (sanitizedSetting == 'no-cache') {
          ageDuration = const Duration();
        }
        if (sanitizedSetting.startsWith('max-age=')) {
          var validSeconds = int.tryParse(sanitizedSetting.split('=')[1]) ?? 0;
          if (validSeconds > 0) {
            ageDuration = Duration(seconds: validSeconds);
          }
        }
      }
    }

    return _receivedTime.add(ageDuration);
  }
}

class DioFileService extends FileService {
  final Dio dio;

  DioFileService(this.dio);

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) {
    return dio
        .get<List<int>>(
          url,
          options: Options(
            headers: headers ?? {},
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) => (status ?? 0) < 500,
            extra: {
              'showLoadingIndicator': false,
            },
          ),
        )
        .then((resp) => DioFileServiceResponse(resp));
  }
}

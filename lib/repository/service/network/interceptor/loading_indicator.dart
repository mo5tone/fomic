import 'package:dio/dio.dart';
import 'package:fomic/common/bloc/hud_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingIndicator extends Interceptor {
  static final provider = Provider.autoDispose((ref) => LoadingIndicator._(ref));
  final HUDBLoC _hudBLoC;

  LoadingIndicator._(Ref ref) : _hudBLoC = ref.read(HUDBLoC.provider.notifier);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _hudBLoC.add(const HUDEvent.show());
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _hudBLoC.add(HUDEvent.toast(err.message));
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _hudBLoC.add(const HUDEvent.dismiss());
    super.onResponse(response, handler);
  }
}

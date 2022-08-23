import 'package:dio/dio.dart';
import 'package:fomic/common/bloc/hud_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ShowLoadingIndicator on RequestOptions {
  bool get showLoadingIndicator => extra['showLoadingIndicator'] ?? true;

  set showLoadingIndicator(bool value) => extra['showLoadingIndicator'] = value;
}

class LoadingIndicator extends Interceptor {
  static final provider = Provider.autoDispose((ref) => LoadingIndicator._(ref.read));
  final HUDBLoC _hudBLoC;

  LoadingIndicator._(Reader read) : _hudBLoC = read(HUDBLoC.provider.notifier);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.showLoadingIndicator) {
      _hudBLoC.add(const HUDEvent.show());
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.requestOptions.showLoadingIndicator) {
      _hudBLoC.add(HUDEvent.toast(err.message));
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.showLoadingIndicator) {
      _hudBLoC.add(const HUDEvent.dismiss());
    }
    super.onResponse(response, handler);
  }
}

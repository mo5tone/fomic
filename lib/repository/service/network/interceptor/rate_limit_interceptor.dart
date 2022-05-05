import 'package:dio/dio.dart';

class RateLimitInterceptor extends QueuedInterceptor {
  final int permits;
  final Duration period;
  final String? host;

  DateTime? lastTime;

  final times = <DateTime>[];

  RateLimitInterceptor({required this.permits, required this.period, this.host})
      : assert(permits > 0),
        assert(period.inMilliseconds > 0);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (host != null && options.uri.host != host) {
      return handler.next(options);
    }
    final delay = times.length < permits
        ? Duration.zero
        : times.last.difference(times.first) > period
            ? Duration.zero
            : times.first.add(period).difference(DateTime.now());
    if (times.length == permits) {
      times.removeAt(0);
    }
    if (delay > Duration.zero) {
      times.add(DateTime.now().add(delay));
      Future.delayed(delay).then((_) => handler.next(options));
    } else {
      times.add(DateTime.now());
      handler.next(options);
    }
  }
}

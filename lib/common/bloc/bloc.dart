import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fomic/model/whoops.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// BLoC stands for Business Logic Component.
abstract class BLoC<Event, State> extends StateNotifier<State> {
  final _eventStreamController = StreamController<Event>.broadcast();
  late StreamSubscription<State> _stateStreamSubscription;

  BLoC(State state) : super(state) {
    _stateStreamSubscription = _eventStreamController.stream.asyncExpand<State>(mapEventToState).listen(_onData, onError: onError);
  }

  void _onData(State s) {
    state = s;
  }

  void add(Event event) {
    if (_eventStreamController.isClosed) return;
    _eventStreamController.add(event);
  }

  @protected
  Stream<State> mapEventToState(Event event);

  @override
  ErrorListener? get onError {
    return (error, stackTrace) {
      log('$runtimeType#onError', error: error, stackTrace: stackTrace);
      if (error is Exception && error is Whoops) {
        error.when(toast: (message) => EasyLoading.showToast(message));
      }
    };
  }

  @mustCallSuper
  @override
  void dispose() {
    _eventStreamController.close();
    _stateStreamSubscription.cancel();
    super.dispose();
  }
}

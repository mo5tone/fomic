import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  @override
  UploadsState get initialState => UploadsState(UploadsStateType.placeholder);

  @override
  Stream<UploadsState> mapEventToState(UploadsEvent event) async* {}
}

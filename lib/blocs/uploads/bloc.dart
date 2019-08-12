import 'package:bloc/bloc.dart';
import 'package:fomic/blocs/uploads/event.dart';
import 'package:fomic/blocs/uploads/state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  @override
  UploadsState get initialState => UploadsState(UploadsStateType.placeholder);

  @override
  Stream<UploadsState> mapEventToState(UploadsEvent event) async* {}
}

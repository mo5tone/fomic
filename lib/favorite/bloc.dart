import 'package:bloc/bloc.dart';
import 'package:fomic/favorite/event.dart';
import 'package:fomic/favorite/state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  @override
  // TODO: implement initialState
  FavoriteState get initialState => null;

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) {
    // TODO: implement mapEventToState
    return null;
  }
}

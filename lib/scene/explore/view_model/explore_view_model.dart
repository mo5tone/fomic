import 'package:fomic/model/constant/source_id.dart';
import 'package:fomic/scene/view_model.dart';

class ExploreViewModel extends ViewModel {
  final sourceIds = SourceID.values;
  SourceID _selectedSourceId;

  SourceID get selectedSourceId => _selectedSourceId;

  set selectedSourceId(SourceID value) {
    if (value != _selectedSourceId) {
      _selectedSourceId = value;
      notifyListeners();
    }
  }
}

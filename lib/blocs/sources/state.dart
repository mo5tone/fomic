import 'package:fomic/blocs/base/state.dart' as base;
import 'package:fomic/sources/base/source.dart';

enum SourcesStateType { stateSwitched }

class SourcesState extends base.State<SourcesStateType> {
  SourcesState(SourcesStateType type) : super(type);

  List<Source> get sources => SourceId.values
      .map((id) => Source.of(id))
      .where((source) => source != null)
      .toList(growable: false);

  @override
  clone({SourcesStateType type}) {
    return SourcesState(
      type ?? this.type,
    );
  }
}

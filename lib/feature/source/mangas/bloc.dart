import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/mangas_page.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:fomic/repository/source/source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc.freezed.dart';

@freezed
class SourceMangasEvent with _$SourceMangasEvent {
  const factory SourceMangasEvent.load() = SourceMangasEventLoad;
  const factory SourceMangasEvent.refresh() = SourceMangasEventRefresh;
}

@freezed
class SourceMangasState with _$SourceMangasState {
  const factory SourceMangasState({@Default([]) List<MangasPage> pages}) = _SourceMangasState;
}

class SourceMangasBLoC extends BLoC<SourceMangasEvent, SourceMangasState> {
  static final provider = StateNotifierProvider.autoDispose<SourceMangasBLoC, SourceMangasState>((ref) => SourceMangasBLoC._(ref));

  final HttpSource _source;

  SourceMangasBLoC._(Ref ref)
      : _source = ref.read(Source.provider) as HttpSource,
        super(const SourceMangasState());

  @override
  Stream<SourceMangasState> mapEventToState(SourceMangasEvent event) {
    return event.when<Stream<SourceMangasState>>(
      load: () async* {
        if (state.pages.isNotEmpty) {
          final mangasPage = await _source.fetchPopularManga(page: state.pages.length + 1);
          yield state.copyWith(pages: [...state.pages, mangasPage]);
        }
      },
      refresh: () async* {
        final mangas = await _source.fetchPopularManga(page: 1);
        yield state.copyWith(pages: [...state.pages, mangas]);
      },
    );
  }
}

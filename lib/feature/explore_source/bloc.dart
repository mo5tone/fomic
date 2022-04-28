import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/source_filter.dart';
import 'package:fomic/model/source_manga_list.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class ExploreSourceEvent with _$ExploreSourceEvent {
  const factory ExploreSourceEvent.load() = ExploreSourceEventLoad;
  const factory ExploreSourceEvent.refresh() = ExploreSourceEventRefresh;
  const factory ExploreSourceEvent.search(String query) = ExploreSourceEventSearch;
  const factory ExploreSourceEvent.filter(List<SourceFilter> filters) = ExploreSourceEventFilter;
}

@freezed
class ExploreSourceState with _$ExploreSourceState {
  const factory ExploreSourceState({
    @Default('') String query,
    @Default([]) List<SourceFilter> filters,
    @Default([]) List<SourceMangaList> pages,
  }) = _ExploreSourceState;
}

class ExploreSourceBLoC extends BLoC<ExploreSourceEvent, ExploreSourceState> {
  static final provider = StateNotifierProvider.autoDispose<ExploreSourceBLoC, ExploreSourceState>((ref) => ExploreSourceBLoC._(ref));

  final HTTPSource _source;

  ExploreSourceBLoC._(Ref ref)
      : _source = ref.read(HTTPSource.provider),
        super(const ExploreSourceState());

  @override
  Stream<ExploreSourceState> mapEventToState(ExploreSourceEvent event) {
    return event.when<Stream<ExploreSourceState>>(
      load: () async* {
        if (state.pages.isNotEmpty && state.pages.last.hasNextPage) {
          if (state.query.isEmpty && state.filters.isEmpty) {
            final page = state.pages.length + 1;
            final mangasPage = await (_source.supportsLatest ? _source.fetchLatestUpdates(page: page) : _source.fetchPopularManga(page: page));
            yield state.copyWith(pages: [...state.pages, mangasPage]);
          } else {
            final mangasPage = await _source.searchManga(page: state.pages.length + 1, query: state.query, filters: state.filters);
            yield state.copyWith(pages: [...state.pages, mangasPage]);
          }
        }
      },
      refresh: () async* {
        if (state.query.isEmpty && state.filters.isEmpty) {
          final mangasPage = await (_source.supportsLatest ? _source.fetchLatestUpdates(page: 1) : _source.fetchPopularManga(page: 1));
          yield state.copyWith(pages: [mangasPage]);
        } else {
          final mangasPage = await _source.searchManga(page: 1, query: state.query, filters: state.filters);
          yield state.copyWith(pages: [mangasPage]);
        }
      },
      search: (query) async* {
        yield state.copyWith(query: query);
        add(const ExploreSourceEvent.refresh());
      },
      filter: (filters) async* {
        yield state.copyWith(filters: filters);
        add(const ExploreSourceEvent.refresh());
      },
    );
  }
}

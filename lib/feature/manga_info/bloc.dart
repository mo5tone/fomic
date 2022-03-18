import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc.freezed.dart';

@freezed
class MangaInfoEvent with _$MangaInfoEvent {
  const factory MangaInfoEvent.refresh() = MangaInfoEventRefresh;
  const factory MangaInfoEvent.favorite() = MangaInfoEventFavorite;
}

@freezed
class MangaInfoState with _$MangaInfoState {
  const factory MangaInfoState({required MangaInfo manga, @Default([]) List<ChapterInfo> chapters}) = _MangaInfoState;
}

class MangaInfoBLoC extends BLoC<MangaInfoEvent, MangaInfoState> {
  static final family = StateNotifierProvider.family<MangaInfoBLoC, MangaInfoState, MangaInfo>((ref, manga) => MangaInfoBLoC._(ref, manga));

  final HttpSource _source;

  MangaInfoBLoC._(Ref ref, MangaInfo manga)
      : _source = ref.read(HttpSource.provider),
        super(MangaInfoState(manga: manga));

  @override
  Stream<MangaInfoState> mapEventToState(MangaInfoEvent event) {
    return event.when(
      refresh: () async* {
        final manga = await _source.fetchMangaDetails(manga: state.manga);
        final chapters = await _source.fetchChapterList(manga: state.manga);
        yield state.copyWith(manga: manga, chapters: chapters);
      },
      favorite: () async* {},
    );
  }
}

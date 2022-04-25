import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/manga_info.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class MangaInfoEvent with _$MangaInfoEvent {
  const factory MangaInfoEvent.refresh() = MangaInfoEventRefresh;
  const factory MangaInfoEvent.swapList() = MangaInfoEventSwapList;
  const factory MangaInfoEvent.favorite() = MangaInfoEventFavorite;
}

@freezed
class MangaInfoState with _$MangaInfoState {
  const factory MangaInfoState({required MangaInfo manga, @Default([]) List<ChapterInfo> chapters}) = _MangaInfoState;
}

class MangaInfoBLoC extends BLoC<MangaInfoEvent, MangaInfoState> {
  static final family = StateNotifierProvider.autoDispose.family<MangaInfoBLoC, MangaInfoState, MangaInfo>((ref, manga) => MangaInfoBLoC._(ref, manga));

  final HTTPSource _source;

  MangaInfoBLoC._(Ref ref, MangaInfo manga)
      : _source = ref.read(HTTPSource.provider),
        super(MangaInfoState(manga: manga));

  @override
  Stream<MangaInfoState> mapEventToState(MangaInfoEvent event) {
    return event.when(
      refresh: () async* {
        final manga = await _source.fetchMangaDetails(manga: state.manga);
        final chapters = await _source.fetchChapterList(manga: state.manga);
        yield state.copyWith(manga: manga, chapters: chapters);
      },
      swapList: () async* {
        yield state.copyWith(chapters: state.chapters.reversed.toList(growable: false));
      },
      favorite: () async* {},
    );
  }
}

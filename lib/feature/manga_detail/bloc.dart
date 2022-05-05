import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_manga.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class MangaDetailEvent with _$MangaDetailEvent {
  const factory MangaDetailEvent.refresh() = MangaDetailEventRefresh;
  const factory MangaDetailEvent.swapList() = MangaDetailEventSwapList;
  const factory MangaDetailEvent.favorite() = MangaDetailEventFavorite;
}

@freezed
class MangaDetailState with _$MangaDetailState {
  const factory MangaDetailState({required SourceManga manga, @Default([]) List<SourceChapter> chapters}) = _MangaDetailState;
}

class MangaDetailBLoC extends BLoC<MangaDetailEvent, MangaDetailState> {
  static final family = StateNotifierProvider.autoDispose
      .family<MangaDetailBLoC, MangaDetailState, SourceManga>((ref, manga) => MangaDetailBLoC._(ref.watch(HTTPSource.provider), manga));

  final HTTPSource source;

  MangaDetailBLoC._(this.source, SourceManga manga) : super(MangaDetailState(manga: manga));

  @override
  Stream<MangaDetailState> mapEventToState(MangaDetailEvent event) {
    return event.when(
      refresh: () async* {
        final manga = await source.fetchMangaDetails(manga: state.manga);
        final chapters = await source.fetchChapterList(manga: state.manga);
        yield state.copyWith(manga: manga, chapters: chapters);
      },
      swapList: () async* {
        yield state.copyWith(chapters: state.chapters.reversed.toList(growable: false));
      },
      favorite: () async* {},
    );
  }
}

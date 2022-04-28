import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class ChapterInfoEvent with _$ChapterInfoEvent {
  const factory ChapterInfoEvent.refresh() = ChapterInfoEventRefresh;
  const factory ChapterInfoEvent.pageChanged(int index) = ChapterInfoEventPageChanged;
}

@freezed
class ChapterInfoState with _$ChapterInfoState {
  const factory ChapterInfoState({
    required SourceChapter chapter,
    @Default(0) int axis,
    @Default(0) int index,
    @Default([]) List<SourcePage> pages,
  }) = _ChapterInfoState;
}

class ChapterInfoBLoC extends BLoC<ChapterInfoEvent, ChapterInfoState> {
  static final family =
      StateNotifierProvider.autoDispose.family<ChapterInfoBLoC, ChapterInfoState, SourceChapter>((ref, chapter) => ChapterInfoBLoC._(ref, chapter));

  final HTTPSource _source;

  ChapterInfoBLoC._(Ref ref, SourceChapter chapter)
      : _source = ref.read(HTTPSource.provider),
        super(ChapterInfoState(chapter: chapter));

  @override
  Stream<ChapterInfoState> mapEventToState(ChapterInfoEvent event) {
    return event.when(
      refresh: () async* {
        var pages = await _source.fetchPageList(chapter: state.chapter);
        pages = pages.map((p) {
          return p.maybeMap(
            url: (pageUrl) async {
              try {
                return await _source.fetchPageImageUrl(page: pageUrl);
              } catch (e) {
                return pageUrl;
              }
            },
            orElse: () => p,
          ) as SourcePage;
        }).toList(growable: false);
        yield state.copyWith(pages: pages);
      },
      pageChanged: (index) async* {
        if (state.index != index) {
          yield state.copyWith(index: index);
        }
      },
    );
  }
}

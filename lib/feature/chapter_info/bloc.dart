import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/chapter_info.dart';
import 'package:fomic/model/page.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class ChapterInfoEvent with _$ChapterInfoEvent {
  const factory ChapterInfoEvent.refresh() = ChapterInfoEventRefresh;
  const factory ChapterInfoEvent.fetch(int index) = ChapterInfoEventFetch;
}

@freezed
class ChapterInfoState with _$ChapterInfoState {
  const factory ChapterInfoState({
    required ChapterInfo chapter,
    @Default(0) int axis,
    @Default(0) int index,
    @Default([]) List<Page> pages,
  }) = _ChapterInfoState;
}

class ChapterInfoBLoC extends BLoC<ChapterInfoEvent, ChapterInfoState> {
  static final family = StateNotifierProvider.family<ChapterInfoBLoC, ChapterInfoState, ChapterInfo>((ref, chapter) => ChapterInfoBLoC._(ref, chapter));

  final HttpSource _source;

  ChapterInfoBLoC._(Ref ref, ChapterInfo chapter)
      : _source = ref.read(HttpSource.provider),
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
          ) as Page;
        }).toList(growable: false);
        yield state.copyWith(pages: pages);
      },
      fetch: (index) async* {},
    );
  }
}

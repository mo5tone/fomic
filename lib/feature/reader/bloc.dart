import 'package:flutter/foundation.dart';
import 'package:fomic/common/bloc/bloc.dart';
import 'package:fomic/model/source_chapter.dart';
import 'package:fomic/model/source_page.dart';
import 'package:fomic/repository/source/http_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bloc.freezed.dart';

@freezed
class ReaderEvent with _$ReaderEvent {
  const factory ReaderEvent.refresh() = ReaderEventRefresh;
  const factory ReaderEvent.pageChanged(int index) = ReaderEventPageChanged;
}

@freezed
class ReaderState with _$ReaderState {
  const factory ReaderState({
    required SourceChapter chapter,
    @Default(0) int axis,
    @Default(0) int index,
    @Default([]) List<SourcePage> pages,
  }) = _ReaderState;
}

class ReaderBLoC extends BLoC<ReaderEvent, ReaderState> {
  static final family =
      StateNotifierProvider.autoDispose.family<ReaderBLoC, ReaderState, SourceChapter>((ref, chapter) => ReaderBLoC._(ref.watch(HTTPSource.provider), chapter));

  final HTTPSource source;

  ReaderBLoC._(this.source, SourceChapter chapter) : super(ReaderState(chapter: chapter));

  @override
  Stream<ReaderState> mapEventToState(ReaderEvent event) {
    return event.when(
      refresh: () async* {
        var pages = await source.fetchPageList(chapter: state.chapter);
        pages = pages.map((p) {
          return p.maybeMap(
            url: (pageUrl) async {
              try {
                return await source.fetchPageImageUrl(page: pageUrl);
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

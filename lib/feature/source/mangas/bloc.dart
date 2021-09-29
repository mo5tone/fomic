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

  SourceMangasBLoC._(ProviderRefBase ref)
      : _source = ref.read(Source.provider) as HttpSource,
        super(const SourceMangasState());

  @override
  Stream<SourceMangasState> mapEventToState(SourceMangasEvent event) {
    return event.when<Stream<SourceMangasState>>(load: () async* {
      if (state.pages.isNotEmpty) {
        final mangas = await _source.fetchPopularManga(page: state.pages.length + 1);
        yield state.copyWith(pages: state.pages..add(mangas));
      }
    }, refresh: () async* {
      final mangas = await _source.fetchPopularManga(page: 1);
      yield state.copyWith(pages: [...state.pages, mangas]);
    });
  }
}

/*
class BooksStateNotifier extends StateNotifier<BooksState> {
  final Source source;
  final HUDStateNotifier hudStateNotifier;

  BooksStateNotifier(Reader read)
      : source = read(rpSource),
        hudStateNotifier = read(rpHUDStateNotifier),
        super(BooksState());

  Future<void> refresh() {
    if (state.loading) return Future.value();
    _setLoading(true);
    return source
        .fetchBooks(page: 0)
        .then((value) => state = state.merge(page: 0, books: value))
        .catchError((err) => _setMessage(err.toString()))
        .whenComplete(() => _setLoading(false));
  }

  Future<void> load() {
    if (state.loading || state.books.isEmpty) return Future.value();
    _setLoading(true);
    return source
        .fetchBooks(page: state.page)
        .then((value) => state = state.merge(page: state.page + 1, books: [...state.books, ...value]))
        .catchError((err) => _setMessage(err.toString()))
        .whenComplete(() => _setLoading(false));
  }

  void _setLoading(bool value) {
    // hudStateNotifier.loading = value;
    state = state.merge(loading: value);
  }

  void _setMessage(String value) {
    // hudStateNotifier.message = value;
  }
}

class BooksState with EquatableMixin {
  final bool loading;
  final int page;
  final List<Book> books;

  BooksState([this.loading = false, this.page = 0, this.books = const []]);

  BooksState merge({bool loading = false, int page, List<Book> books}) {
    return BooksState(loading, page ?? this.page, books ?? this.books);
  }

  @override
  List<Object> get props => [loading, page, books];
}
*/

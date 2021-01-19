import 'package:equatable/equatable.dart';
import 'package:fomic/common/state/hud_state.dart';
import 'package:fomic/model/entity/book.dart';
import 'package:fomic/model/source/source.dart';
import 'package:hooks_riverpod/all.dart';

final rpBooksStateNotifier = StateNotifierProvider((ref) => BooksStateNotifier(ref.read));

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
        .then((value) => state = state.merge(page: 0, books: [...state.books, ...value]))
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
    hudStateNotifier.loading = value;
    state = state.merge(loading: value);
  }

  void _setMessage(String value) {
    hudStateNotifier.message = value;
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

part of 'delegate.dart';

final rpBooksSearchStateNotifier = StateNotifierProvider((ref) => BooksSearchStateNotifier(ref.read));

class BooksSearchStateNotifier extends StateNotifier<BooksSearchState> {
  final Source source;
  final HUDStateNotifier hudStateNotifier;

  BooksSearchStateNotifier(Reader read)
      : source = read(rpSource),
        hudStateNotifier = read(rpHUDStateNotifier),
        super(BooksSearchState());

  Future<void> search(String query) async {
    assert(query?.isNotEmpty ?? false);
    if (state.loading) return;
    if (query != state.query) {
      state = BooksSearchState(query);
    }
    _setLoading(true);
    try {
      final books = await source.fetchBooks(page: state.page, query: state.query);
      state = state.merge(page: state.page + 1, books: state.books + books);
    } catch (err) {
      _setMessage('${err}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    hudStateNotifier.loading = value;
    state = state.merge(loading: value);
  }

  void _setMessage(String value) {
    hudStateNotifier.message = value;
  }
}

class BooksSearchState with EquatableMixin {
  final String query;
  final bool loading;
  final int page;
  final List<Book> books;

  BooksSearchState([this.query = '', this.loading = false, this.page = 0, this.books = const []]);

  BooksSearchState merge({String query, bool loading, int page, List<Book> books}) {
    return BooksSearchState(query ?? this.query, loading ?? this.loading, page ?? this.page, books ?? this.books);
  }

  @override
  List<Object> get props => [query, loading, page, books];
}

part of './screen.dart';

final rpChaptersStateNotifier = StateNotifierProvider.family<ChaptersStateNotifier, Book>((ref, book) => ChaptersStateNotifier(ref.read, book));

class ChaptersStateNotifier extends StateNotifier<ChaptersState> {
  final Source source;
  final Favorite favorite;
  final HUDStateNotifier hudStateNotifier;

  ChaptersStateNotifier(Reader read, Book book)
      : source = read(rpSource),
        favorite = read(rpFavorite),
        hudStateNotifier = read(rpHUDStateNotifier),
        super(ChaptersState(book)) {
    favorite.contains(source.id, book).then((favorited) => state = state.merge(favorited: favorited));
  }

  Future<void> fetch() async {
    var book = state.book;
    _setLoading(true);
    try {
      final results = await Future.wait([source.fetchBook(book), source.fetchChapters(book)]);
      if (results.length > 1 && results[0] is Book && results[1] is List<Chapter>) {
        state = state.merge(book: results[0], chapters: results[1]);
      }
    } catch (err) {
      _setMessage('${err}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleFavorite() {
    state = state.merge(favorited: !state.favorited);
    return favorite.toggle(source.id, state.book);
  }

  void _setLoading(bool value) {
    hudStateNotifier.loading = value;
    state = state.merge(loading: value);
  }

  void _setMessage(String value) {
    hudStateNotifier.message = value;
  }
}

class ChaptersState with EquatableMixin {
  final Book book;
  final bool loading;
  final bool favorited;
  final List<Chapter> chapters;

  ChaptersState([this.book, this.loading = false, this.favorited = false, this.chapters = const []]);

  ChaptersState merge({Book book, bool loading, bool favorited, List<Chapter> chapters}) {
    return ChaptersState(book ?? this.book, loading ?? this.loading, favorited ?? this.favorited, chapters ?? this.chapters);
  }

  @override
  List<Object> get props => [book, loading, favorited, chapters];
}

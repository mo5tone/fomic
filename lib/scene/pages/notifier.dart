part of './screen.dart';

final rpPagesStateNotifier = StateNotifierProvider.family<PagesStateNotifier, Chapter>((ref, chapter) => PagesStateNotifier(ref.read, chapter));

class PagesStateNotifier extends StateNotifier<PagesState> {
  final Source source;
  final HUDStateNotifier hudStateNotifier;
  final Chapter chapter;

  PagesStateNotifier(Reader read, this.chapter)
      : source = read(rpSource),
        hudStateNotifier = read(rpHUDStateNotifier),
        super(PagesState());

  Future<void> fetch() async {
    _setLoading(true);
    try {
      final pages = await source.fetchPages(chapter);
      state = state.merge(pages: pages);
    } catch (err) {
      _setMessage('${err}');
    } finally {
      _setLoading(false);
    }
  }

  set currentIndex(int value) {
    state = state.merge(currentIndex: value);
  }

  void _setLoading(bool value) {
    hudStateNotifier.loading = value;
    state = state.merge(loading: value);
  }

  void _setMessage(String value) {
    hudStateNotifier.message = value;
  }
}

class PagesState with EquatableMixin {
  final bool loading;
  final int currentIndex;
  final List<Page> pages;

  PagesState([this.loading = false, this.currentIndex = 0, this.pages = const []]);

  PagesState merge({bool loading, int currentIndex, List<Page> pages}) {
    return PagesState(loading ?? this.loading, currentIndex ?? this.currentIndex, pages ?? this.pages);
  }

  @override
  List<Object> get props => [loading, currentIndex, pages];
}

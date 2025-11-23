class SearchItem {
  final String id;
  final String title;
  final SearchItemType type;

  const SearchItem({required this.id, required this.title, required this.type});
}

enum SearchItemType { history, popular }

class FavoriteManager {
  static final Set<String> _favorites = {};

  static bool isFavorite(String text) => _favorites.contains(text);

  static void toggleFavorite(String text) {
    if (_favorites.contains(text)) {
      _favorites.remove(text);
    } else {
      _favorites.add(text);
    }
  }

  static List<String> get favorites => _favorites.toList();
}

part of 'favorite_cubit.dart';

class FavoriteState {
  final Set<String> favorites;

  const FavoriteState({required this.favorites});

  FavoriteState copyWith({Set<String>? favorites}) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
    );
  }

  bool isFavorite(String text) => favorites.contains(text);
}

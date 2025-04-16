// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final SharedPreferences prefs;

  FavoriteCubit({required this.prefs}) : super(const FavoriteState(favorites: {})) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final saved = prefs.getStringList('favorites') ?? [];
    emit(state.copyWith(favorites: saved.toSet()));
  }

  Future<void> toggleFavorite(String text) async {
    final current = state.favorites.toSet();

    if (current.contains(text)) {
      current.remove(text);
    } else {
      current.add(text);
    }

    await prefs.setStringList('favorites', current.toList());
    emit(state.copyWith(favorites: current));
  }
}

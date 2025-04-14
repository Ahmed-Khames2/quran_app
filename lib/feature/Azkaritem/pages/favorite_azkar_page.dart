import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theam_mood_with_block/cubitss/azkar_cubit/favorite_cubit.dart';

class FavoriteAzkarPage extends StatefulWidget {
  @override
  State<FavoriteAzkarPage> createState() => _FavoriteAzkarPageState();
}

class _FavoriteAzkarPageState extends State<FavoriteAzkarPage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _goToPage(int index) {
    final favorites = context.read<FavoriteCubit>().state.favorites;
    if (index >= 0 && index < favorites.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      appBar: AppBar(
        title: Text("الأذكار المفضلة"),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final favorites = state.favorites.toList();

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                "لا يوجد أذكار مفضلة بعد",
                style: TextStyle(color: textColor, fontSize: 18),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: favorites.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final text = favorites[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Card(
                        color: theme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(Icons.favorite, color: Colors.red, size: 30),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 22,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<FavoriteCubit>().toggleFavorite(text);
                                  if (currentIndex >= state.favorites.length - 1) {
                                    setState(() {
                                      currentIndex = state.favorites.length - 2 < 0 ? 0 : state.favorites.length - 2;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text("إزالة من المفضلة"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: textColor),
                      onPressed: () => _goToPage(currentIndex - 1),
                    ),
                    Text(
                      "${currentIndex + 1} / ${favorites.length}",
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: textColor),
                      onPressed: () => _goToPage(currentIndex + 1),
                    ),
                  ],
                ),
              ),
              
            ],
          );
        },
      ),
    );
  }
}

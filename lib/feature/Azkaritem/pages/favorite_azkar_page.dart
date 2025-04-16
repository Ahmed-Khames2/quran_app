import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/cubitss/azkar_cubit/favorite_cubit.dart';

class FavoriteAzkarPage extends StatefulWidget {
  const FavoriteAzkarPage({super.key});

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
        title: Text(
          "الأذكار المفضلة",
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final favorites = state.favorites.toList();

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                "لا يوجد أذكار مفضلة بعد",
                style: TextStyle(color: textColor, fontSize: 18.sp),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Card(
                        color: theme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             const  Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                   Icon(Icons.favorite, color: Colors.red, size: 30),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 22.sp,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
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
                padding: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: textColor, size: 24.sp),
                      onPressed: () => _goToPage(currentIndex - 1),
                    ),
                    Text(
                      "${currentIndex + 1} / ${favorites.length}",
                      style: TextStyle(color: textColor, fontSize: 16.sp),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: textColor, size: 24.sp),
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

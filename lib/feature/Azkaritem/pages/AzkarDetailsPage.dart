// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/cubitss/azkar_cubit/favorite_cubit.dart';
import '../models/zkermodel.dart';
// import '../db/favorite_manager.dart';

class AzkarDetailsPage extends StatefulWidget {
  final AzkarItem item;

  const AzkarDetailsPage({super.key, required this.item});

  @override
  State<AzkarDetailsPage> createState() => _AzkarDetailsPageState();
}

class _AzkarDetailsPageState extends State<AzkarDetailsPage> {
  late PageController _pageController;
  int currentPage = 0;
  int repeatCount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextZikr() {
    final currentZikr = widget.item.azkarTexts[currentPage];

    if (repeatCount < currentZikr.repeat - 1) {
      setState(() {
        repeatCount++;
      });
    } else {
      if (currentPage < widget.item.azkarTexts.length - 1) {
        setState(() {
          currentPage++;
          repeatCount = 0;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _showFinishedDialog();
      }
    }
  }

  void _showFinishedDialog() {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: theme.colorScheme.surface,
        title: Row(
          children: [
            Icon(Icons.check_circle, color: theme.colorScheme.primary),
            SizedBox(width: 8.w),
            Text(
              "تهانينا",
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: 'me_quran',
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
        content: Text(
          "لقد أنهيت ${widget.item.title} بنجاح!",
          style: theme.textTheme.bodyLarge?.copyWith(
            // ignore: deprecated_member_use
            color: theme.colorScheme.onBackground,
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.done,
                color: theme.colorScheme.primary, size: 24.sp),
            label: Text(
              "تم",
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final azkarTexts = widget.item.azkarTexts;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.title, style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 4.h),
            Text(
              "${currentPage + 1} / ${widget.item.azkarTexts.length}",
              style: TextStyle(fontSize: 14.sp, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: azkarTexts.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  repeatCount = 0;
                });
              },
              itemBuilder: (context, index) {
                final zikr = azkarTexts[index];
                return BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final isFav = state.isFavorite(zikr.text);

                    return Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Card(
                        color: theme.cardColor,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    zikr.text,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontSize: 22.sp,
                                      height: 2.1,
                                      fontFamily: 'me_quran',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              IconButton(
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.redAccent,
                                  size: 30.sp,
                                ),
                                onPressed: () {
                                  context
                                      .read<FavoriteCubit>()
                                      .toggleFavorite(zikr.text);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextZikr,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 40.w, vertical: 16.h),
                backgroundColor: theme.appBarTheme.backgroundColor,
              ),
              child: Text(
                "${repeatCount + 1} / ${azkarTexts[currentPage].repeat}",
                style: TextStyle(fontSize: 22.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

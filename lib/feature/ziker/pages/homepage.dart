import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theam_mood_with_block/cubitss/tasbeeh_cubit/tasbeeh_cubit.dart';
import 'package:theam_mood_with_block/cubitss/tasbeeh_cubit/tasbeeh_state.dart';

class DhikrPage extends StatelessWidget {
  static const String routeName = '/dhikr';
  const DhikrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // الحصول على الثيم الحالي
    final pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "تسبيح",
              style: TextStyle(
                fontSize: 26.sp, // استخدام screenutil لحجم الخط
                fontWeight: FontWeight.bold,
                // fontFamily: 'me_quran',
                shadows: const [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            BlocBuilder<TasbeehCubit, TasbeehState>(
              builder: (context, state) {
                return Text(
                  'الجولة: ${state.rounds[state.currentIndex]}',
                  style: TextStyle(
                    fontSize: 14.sp, // استخدام ScreenUtil للأبعاد
                  ),
                );
              },
            ),
            SizedBox(height: 9.h),
          ],
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () => context.read<TasbeehCubit>().resetTasbeeh(),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () => _showRepeatSelectionSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: state.azkar.length,
                    onPageChanged: (index) {
                      context.read<TasbeehCubit>().setCurrentIndex(index);
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          state.azkar[index],
                          style: TextStyle(
                            fontSize: 38.sp, // استخدام ScreenUtil للأبعاد
                            fontFamily: 'me_quran',
                            fontWeight: FontWeight.w500,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  '${state.counts[state.currentIndex]} / ${state.repeatCount}',
                  style: TextStyle(
                    fontSize: 22.sp, // استخدام ScreenUtil للأبعاد
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 16.h), // استخدام ScreenUtil للمسافات
                buildBeads(context, state.counts[state.currentIndex],
                    state.repeatCount),
                SizedBox(height: 16.h),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<TasbeehCubit, TasbeehState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 24.w), // استخدام ScreenUtil للمسافات
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    if (state.currentIndex > 0) {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      context
                          .read<TasbeehCubit>()
                          .setCurrentIndex(state.currentIndex - 1);
                    }
                  },
                ),
                SizedBox(
                  width: 150.w, // استخدام ScreenUtil للأبعاد
                  height: 90.h, // استخدام ScreenUtil للأبعاد
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TasbeehCubit>().incrementCount();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.appBarTheme.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              60.r), // استخدام ScreenUtil للأبعاد
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 8.h), // استخدام ScreenUtil للمسافات
                      child: Text(
                        "تسبيح",
                        style: TextStyle(
                            fontSize: 20.sp, // استخدام ScreenUtil للأبعاد
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: () {
                    if (state.currentIndex < state.azkar.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      context
                          .read<TasbeehCubit>()
                          .setCurrentIndex(state.currentIndex + 1);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBeads(BuildContext context, int currentCount, int repeatCount) {
    final theme = Theme.of(context); // الحصول على الثيم الحالي
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.w, // استخدام ScreenUtil للأبعاد
      runSpacing: 8.h, // استخدام ScreenUtil للمسافات
      children: List.generate(repeatCount, (index) {
        return CircleAvatar(
          radius: 9.r, // استخدام ScreenUtil للأبعاد
          backgroundColor: index < currentCount
              ? theme.primaryColor
              // ignore: deprecated_member_use
              : theme.primaryColor.withOpacity(0.3),
        );
      }),
    );
  }

  void _showRepeatSelectionSheet(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(16.w), // استخدام ScreenUtil للمسافات
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ضبط عدد التكرارات',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'me_quran',
                        fontSize: 20.sp,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            Wrap(
              spacing: 12.w, // استخدام ScreenUtil للأبعاد
              runSpacing: 12.h, // استخدام ScreenUtil للمسافات
              children: [3, 33, 99, 100].map((e) {
                return SizedBox(
                  width: 160.w, // تحديد عرض ثابت لكل زر
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.appBarTheme.backgroundColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h), // استخدام ScreenUtil للمسافات
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.r), // استخدام ScreenUtil للأبعاد
                      ),
                    ),
                    onPressed: () {
                      context.read<TasbeehCubit>().changeRepeatCount(e);
                      Navigator.pop(context);
                    },
                    child: Text(
                      '$e مرة',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'me_quran',
                        color: Colors.white,
                      ),
                    ), // استخدام ScreenUtil للأبعاد
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 16.h), // استخدام ScreenUtil للمسافات
          ],
        ),
      ),
    );
  }
}

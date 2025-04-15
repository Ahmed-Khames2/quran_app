import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            const Text("تسبيح"),
            BlocBuilder<TasbeehCubit, TasbeehState>(
              builder: (context, state) {
                return Text(
                  'الجولة: ${state.rounds[state.currentIndex]}',
                  style: TextStyle(
                    fontSize: 12,
                    // color: theme., // اللون من الثيم
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              // color: theme.iconTheme.color, // اللون من الثيم
            ),
            onPressed: () => context.read<TasbeehCubit>().resetTasbeeh(),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              // color: theme.iconTheme.color, // اللون من الثيم
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
                            fontSize: 40,
                            fontFamily: 'me_quran',
                            fontWeight: FontWeight.bold,
                            color: theme
                                .textTheme.bodyLarge?.color, // اللون من الثيم
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
                    fontSize: 22,
                    color: theme.textTheme.bodyLarge?.color, // اللون من الثيم
                  ),
                ),
                const SizedBox(height: 16),
                buildBeads(context, state.counts[state.currentIndex],
                    state.repeatCount),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<TasbeehCubit, TasbeehState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    // color: theme.iconTheme.color, // اللون من الثيم
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
                Container(
                  width: 150,
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TasbeehCubit>().incrementCount();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.appBarTheme.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        )),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                        "تسبيح",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            // fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    // color: theme.iconTheme.color, // اللون من الثيم
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
      spacing: 8,
      runSpacing: 8,
      children: List.generate(repeatCount, (index) {
        return CircleAvatar(
          radius: 10,
          backgroundColor: index < currentCount
              ? theme.primaryColor // اللون من الثيم
              : theme.primaryColor.withOpacity(0.3), // اللون من الثيم
        );
      }),
    );
  }

  void _showRepeatSelectionSheet(BuildContext context) {
    final theme = Theme.of(context); // الحصول على الثيم
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // العنوان مع زر الإغلاق
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ضبط عدد التكرارات',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
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
            // خيارات التكرار
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [3, 33, 99, 100].map((e) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.appBarTheme.backgroundColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.read<TasbeehCubit>().changeRepeatCount(e);
                    Navigator.pop(context);
                  },
                  child: Text('$e مرة', style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

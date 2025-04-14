import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theam_mood_with_block/cubitss/tasbeeh_cubit/tasbeeh_cubit.dart';
import 'package:theam_mood_with_block/cubitss/tasbeeh_cubit/tasbeeh_state.dart';

class DhikrPage extends StatelessWidget {
  static const String routeName = '/dhikr';
  const DhikrPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TasbeehCubit>().resetTasbeeh(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
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
                          style: const TextStyle(
                            fontSize: 32,
                            fontFamily: 'quran',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  '${state.counts[state.currentIndex]} / ${state.repeatCount}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 16),
                buildBeads(context, state.counts[state.currentIndex], state.repeatCount),
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
                // السهم اللي بيرجع للخلف
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (state.currentIndex > 0) {
                      context
                          .read<TasbeehCubit>()
                          .setCurrentIndex(state.currentIndex - 1);
                    }
                  },
                ),
                // زر التسبيح
                ElevatedButton(
                  onPressed: () {
                    context.read<TasbeehCubit>().incrementCount();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text("تسبيح", style: TextStyle(fontSize: 18)),
                  ),
                ),
                // السهم اللي بيقدم للأمام
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (state.currentIndex < state.azkar.length - 1) {
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
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(repeatCount, (index) {
        return CircleAvatar(
          radius: 10,
          backgroundColor: index < currentCount
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.3),
        );
      }),
    );
  }

  void _showRepeatSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [3, 33, 99, 100].map((e) {
            return ListTile(
              title: Text('$e'),
              onTap: () {
                context.read<TasbeehCubit>().changeRepeatCount(e);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

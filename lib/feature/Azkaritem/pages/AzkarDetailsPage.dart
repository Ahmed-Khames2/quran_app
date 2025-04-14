import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theam_mood_with_block/cubitss/azkar_cubit/favorite_cubit.dart';
import '../models/zkermodel.dart';  // التأكد من استيراد ZekrModel
import '../db/favorite_manager.dart';

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

    // تكرار الذكر بناءً على قيمته في repeat
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
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تهانينا"),
        content: Text("لقد انتهيت من ${widget.item.title}!"),
        actions: [
          TextButton(
            child: const Text("حسناً"),
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
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.title),
            const SizedBox(height: 4),
            Text(
              "${currentPage + 1} / ${widget.item.azkarTexts.length}",
              style: const TextStyle(fontSize: 14, color: Colors.white70),
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
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        color: theme.cardColor,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    zikr.text,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontSize: 20,
                                      height: 1.8,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              IconButton(
                                icon: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.redAccent,
                                  size: 30,
                                ),
                                onPressed: () {
                                  context.read<FavoriteCubit>().toggleFavorite(zikr.text);
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextZikr,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
              ),
              child: Text(
                "${repeatCount + 1} / ${azkarTexts[currentPage].repeat}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
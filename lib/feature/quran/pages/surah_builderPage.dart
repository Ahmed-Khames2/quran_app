import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:theam_mood_with_block/core/constant.dart';
import 'package:theam_mood_with_block/feature/quran/widgets/RetunBasmalaWidget.dart';

class SurahBuilder extends StatefulWidget {
  final int sura;
  final List arabic;
  final String suraName;
  int ayah;

  SurahBuilder({
    super.key,
    required this.sura,
    required this.arabic,
    required this.suraName,
    required this.ayah,
  });

  @override
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  bool view = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }

  jumbToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
        index: widget.ayah,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
      );
    }
    fabIsClicked = false;
  }

  Row verseBuilder(int index, int previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.arabic[index + previousVerses]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: arabicFontSize,
                  fontFamily: arabicFont,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SafeArea SingleSuraBuilder(int LengthOfSura) {
    String fullSura = '';
    int previousVerses = 0;

    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses += noOfVerses[i];
      }
    }

    if (!view) {
      for (int i = 0; i < LengthOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }
    }

    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: view
            ? ScrollablePositionedList.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      (index != 0 || widget.sura == 0 || widget.sura == 8)
                          ? const SizedBox()
                          : const RetunBasmala(),
                      Container(
                        color: index % 2 != 0
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).cardColor,
                        child: PopupMenuButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: verseBuilder(index, previousVerses),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () {
                                saveBookMark(widget.sura + 1, index);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.bookmark_add,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 10),
                                  const Text('Bookmark'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.share,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 10),
                                  const Text('Share'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: LengthOfSura,
              )
            : ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.sura + 1 != 1 && widget.sura + 1 != 9
                          ? const RetunBasmala()
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          fullSura,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: mushafFontSize,
                            fontFamily: arabicFont,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.sura];

    return Scaffold(
      appBar: AppBar(
        leading: Tooltip(
          message: 'Mushaf Mode',
          child: IconButton(
            icon: const Icon(Icons.chrome_reader_mode),
            onPressed: () {
              setState(() {
                view = !view;
              });
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.suraName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'quran',
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: SingleSuraBuilder(LengthOfSura),
    );
  }
}

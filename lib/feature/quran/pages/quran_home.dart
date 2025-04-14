import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/core/constant.dart';
import 'package:theam_mood_with_block/feature/quran/widgets/arabic_sura_numberWidget.dart';
import 'surah_builderPage.dart';

class QuranHome extends StatefulWidget {
  const QuranHome({super.key});

  @override
  State<QuranHome> createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // نجيب الثيم الحالي
    // final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'اذهب للعلامة',
        backgroundColor: theme.primaryColor, // من الثيم
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookmark() == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahBuilder(
                  arabic: quran[0],
                  sura: bookmarkedSura - 1,
                  suraName: arabicName[bookmarkedSura - 1]['name'],
                  ayah: bookmarkedAyah,
                ),
              ),
            );
          }
        },
        child: const Icon(
          Icons.bookmark,
          // color: theme.colorScheme.onPrimary,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quran",
            // style: theme.textTheme.titleLarge?.copyWith(
            //   fontSize: 32,
            //   fontWeight: FontWeight.bold,
            //   shadows: const [
            //     Shadow(
            //       offset: Offset(1, 1),
            //       blurRadius: 2.0,
            //       color: Colors.black26,
            //     ),
            //   ],
            // ),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2.0,
                  color: Colors.black26,
                ),
              ],
            )),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Center(child: Text('حدث خطأ'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('لا توجد بيانات'));
          } else {
            return indexCreator(snapshot.data, context);
          }
        },
      ),
    );
  }

  Widget indexCreator(quran, context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, i) {
          return Container(
            color: i % 2 == 0
                ? theme.cardColor.withOpacity(0.95)
                : theme.cardColor.withOpacity(0.85),
            child: TextButton(
              onPressed: () {
                fabIsClicked = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahBuilder(
                      arabic: quran[0],
                      sura: i,
                      suraName: arabicName[i]['name'],
                      ayah: 0,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  ArabicSuraNumber(i: i),
                  const SizedBox(width: 5),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    arabicName[i]['name'],
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'quran',
                      color: theme.textTheme.bodyLarge?.color,
                      shadows: const [
                        Shadow(
                          offset: Offset(.5, .5),
                          blurRadius: 1.0,
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

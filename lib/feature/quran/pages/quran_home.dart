import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة screenutil
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "القرآن الكريم",
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 26.sp, // استخدام screenutil لحجم الخط
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ',
                style: theme.textTheme.bodyLarge,
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'لا توجد بيانات',
                style: theme.textTheme.bodyLarge,
              ),
            );
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
                // ignore: deprecated_member_use
                ? theme.cardColor.withOpacity(0.95)
                // ignore: deprecated_member_use
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
              style: TextButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                backgroundColor: Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      arabicName[i]['name'],
                      style: TextStyle(
                        fontSize: 30.sp, // استخدام screenutil لحجم الخط
                        fontFamily: 'me_quran',
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
                  ),
                  ArabicSuraNumber(i: i),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

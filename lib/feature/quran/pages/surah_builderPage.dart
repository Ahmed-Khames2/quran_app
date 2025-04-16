// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استيراد مكتبة screenutil
import 'package:theam_mood_with_block/core/constant.dart';
import 'package:theam_mood_with_block/feature/quran/pages/settingsPage.dart';
import 'package:theam_mood_with_block/feature/quran/widgets/RetunBasmalaWidget.dart';

// ignore: must_be_immutable
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
  // ignore: library_private_types_in_public_api
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  @override
  Widget build(BuildContext context) {
    int previousVerses = 0;

    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses += noOfVerses[i];
      }
    }

    // ignore: non_constant_identifier_names
    int LengthOfSura = noOfVerses[widget.sura];
    String fullSura = '';

    for (int i = 0; i < LengthOfSura; i++) {
      fullSura += widget.arabic[i + previousVerses]['aya_text'];
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          widget.suraName,
          style: TextStyle(
            fontSize: 30.sp, // استخدام screenutil لحجم الخط
            fontWeight: FontWeight.bold,
            fontFamily: 'me_quran',
            shadows:const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
        actions: [
          Tooltip(
            message: 'Settings',
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                final needRefresh = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
                if (needRefresh == true) {
                  setState(() {}); // تحدث الواجهة تلقائيًا بعد الرجوع
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.sura + 1 != 1 && widget.sura + 1 != 9
                      ? const RetunBasmala()
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.all(8.0.w), // استخدام screenutil في padding
                    child: Text(
                      fullSura,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: mushafFontSize.sp, // استخدام screenutil لحجم الخط
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
      ),
    );
  }
}

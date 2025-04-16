import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // إضافة مكتبة ScreenUtil
import 'package:theam_mood_with_block/feature/names_of_allah/models/allah_name_model.dart';

class NamesOfAllahPage extends StatefulWidget {
  const NamesOfAllahPage({super.key});

  @override
  State<NamesOfAllahPage> createState() => _NamesOfAllahPageState();
}

class _NamesOfAllahPageState extends State<NamesOfAllahPage> {
  List<AllahName> allahNames = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllahNames();
  }

  Future<void> _loadAllahNames() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/allah_names.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        allahNames = AllahNamesRepository.loadAllahNames(jsonList);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error loading Allah names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أسماء الله الحسنى',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: sqrt1_2,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            )
          : ListView.builder(
              itemCount: allahNames.length,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h), // استخدام ScreenUtil هنا
              itemBuilder: (context, index) {
                final name = allahNames[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8.h), // استخدام ScreenUtil هنا
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r), // استخدام ScreenUtil هنا
                  ),
                  color: theme.cardColor,
                  child: Padding(
                    padding: EdgeInsets.all(16.w), // استخدام ScreenUtil هنا
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 100.h, // استخدام ScreenUtil هنا
                              child: Text(
                                name.name,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: name.number == 85 ? 20.sp : 45.sp, // استخدام ScreenUtil هنا
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'quran_smart',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16.w), // استخدام ScreenUtil هنا
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 12.w), // استخدام ScreenUtil هنا
                                decoration: BoxDecoration(
                                  color: isDark
                                      // ignore: deprecated_member_use
                                      ? theme.colorScheme.surfaceVariant
                                      : theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12.r), // استخدام ScreenUtil هنا
                                ),
                                child: Text(
                                  name.number.toString(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h), // استخدام ScreenUtil هنا
                              Text(
                                name.name,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: name.number == 85 ? 25.sp : 30.sp, // استخدام ScreenUtil هنا
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'me_quran',
                                ),
                              ),
                              SizedBox(height: 4.h), // استخدام ScreenUtil هنا
                              Text(
                                name.description,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: 16.sp, // استخدام ScreenUtil هنا
                                  color: theme.textTheme.bodyLarge?.color
                                      // ignore: deprecated_member_use
                                      ?.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.right,
                                // ignore: deprecated_member_use
                                textScaleFactor: 1.2,
                              ),
                            ],
                          ),
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

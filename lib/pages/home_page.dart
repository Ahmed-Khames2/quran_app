import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/names_of_allah/pages/names_page.dart';
import 'package:theam_mood_with_block/feature/quran/pages/quran_home.dart';
import 'package:theam_mood_with_block/feature/ziker/pages/homepage.dart';

/// الصفحة الرئيسية للتطبيق.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // شريط التطبيق يحتوي على عنوان وزر الإعدادات.
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // الانتقال إلى صفحة الإعدادات عند الضغط على الأيقونة.
                Navigator.pushNamed(context, '/setting');
              },
            )
          ],
        ),
        // جسم الصفحة يحتوي على نص في المنتصف.
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // الانتقال إلى صفحة تسبيح عند الضغط على الزر.
                // Navigator.pushNamed(context, DhikrPage.routeName);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NamesOfAllahPage()));
              },
              child: const Text("click"),
            ), ElevatedButton(
              onPressed: () {
                // الانتقال إلى صفحة تسبيح عند الضغط على الزر.
                // Navigator.pushNamed(context, DhikrPage.routeName);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const QuranHome()));
              },
              child: const Text("QuranHome"),
            ),
          //  QuranHome
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
              child: Text('hllllllllllo'),
            ),
            const Text("Hello World"),
          ],
        ));
  }
}

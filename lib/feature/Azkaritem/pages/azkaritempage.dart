import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/Azkaritem/db/azkar_data.dart';
import 'favorite_azkar_page.dart';
import 'AzkarDetailsPage.dart';

class AzkarHomePage extends StatelessWidget {
  const AzkarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأذكار"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: "الأذكار المفضلة",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  FavoriteAzkarPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "قائمة الأذكار",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: azkarList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = azkarList[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Theme.of(context).cardColor,
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  trailing: Icon(item.icon, color: Colors.greenAccent),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AzkarDetailsPage(item: item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

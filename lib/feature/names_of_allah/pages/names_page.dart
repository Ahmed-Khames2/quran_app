import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        title: Text(
          'أسماء الله الحسنى',
          // style: theme.textTheme.titleLarge?.copyWith(
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        centerTitle: true,
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemBuilder: (context, index) {
                final name = allahNames[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: theme.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: Text(
                                name.name,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: name.number == 85 ? 20 : 45,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'quran_smart',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? theme.colorScheme.surfaceVariant
                                      : theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  name.number.toString(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                name.name,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: name.number == 85 ? 25 : 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'me_quran',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                name.description,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: 16,
                                  color: theme.textTheme.bodyLarge?.color
                                      ?.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
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

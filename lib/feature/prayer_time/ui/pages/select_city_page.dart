import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/city_service.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  List<CityModel> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  Future<void> loadCities() async {
    final loadedCities = await CityService.loadCities();
    setState(() {
      cities = loadedCities;
      isLoading = false;
    });
  }

  Future<void> _showConfirmDialog(CityModel city) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد تغيير المدينة'),
        content: Text('هل أنت متأكد أنك تريد تغيير المدينة إلى ${city.name}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );

    if (isConfirmed == true) {
      Navigator.pop(context, city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اختر المدينة")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  title: Text(city.name),
                  onTap: () {
                    _showConfirmDialog(city); // Call the confirmation dialog
                  },
                );
              },
            ),
    );
  }
}

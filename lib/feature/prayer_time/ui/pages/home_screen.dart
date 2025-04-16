import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String locationMessage = 'جارٍ تحديد الموقع...';
  final LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      final position = await locationService.getCurrentLocation();
      await locationService.saveLocation(position);
      setState(() {
        locationMessage =
            'الموقع الحالي:\nخط العرض: ${position.latitude}, خط الطول: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        locationMessage = 'فشل تحديد الموقع: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
       
      ),
    );
  }
}

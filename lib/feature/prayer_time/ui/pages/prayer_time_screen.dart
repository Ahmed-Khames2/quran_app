import 'dart:io';

import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/prayer_time_service.dart';
import 'package:theam_mood_with_block/feature/prayer_time/ui/pages/select_city_page.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:theam_mood_with_block/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Import intl package

class PrayerTimeScreen extends StatefulWidget {
  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  late PrayerTimeService prayerTimeService;
  PrayerTimes? prayerTimes;
  late Coordinates coordinates;
  CityModel? selectedCity;

  @override
  void initState() {
    super.initState();
    _checkExactAlarmPermission();
    _loadSelectedCity(); // Load the selected city when the screen is initialized
  }

  Future<void> _checkExactAlarmPermission() async {
    if (Platform.isAndroid && (await Permission.scheduleExactAlarm.isDenied)) {
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    }
  }

  Future<void> _loadSelectedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final cityName = prefs.getString('selectedCity');
    final cityLat = prefs.getDouble('cityLat');
    final cityLng = prefs.getDouble('cityLng');

    if (cityName != null && cityLat != null && cityLng != null) {
      setState(() {
        selectedCity = CityModel(name: cityName, lat: cityLat, lng: cityLng);
        coordinates = Coordinates(cityLat, cityLng);
        _loadPrayerTimes(); // Load prayer times after setting the city and coordinates
      });
    } else {
      // Default to Cairo if no city is selected
      setState(() {
        selectedCity = CityModel(name: "Cairo", lat: 31.2001, lng: 29.9187);
        coordinates = Coordinates(31.2001, 29.9187); // Cairo as default
        _loadPrayerTimes();
      });
    }
  }

  Future<void> _saveSelectedCity(CityModel city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city.name);
    await prefs.setDouble('cityLat', city.lat);
    await prefs.setDouble('cityLng', city.lng);
  }

  void _loadPrayerTimes() async {
    prayerTimeService = PrayerTimeService(coordinates);
    final now = DateTime.now();
    try {
      prayerTimes = prayerTimeService.getPrayerTimes(now);
      _schedulePrayerTimes();
    } catch (e) {
      print('Error loading prayer times: $e');
    }
  }

  void _schedulePrayerTimes() async {
    if (prayerTimes != null) {
      await _scheduleNotification(prayerTimes!.fajr, 'صلاة الفجر', 1);
      await _scheduleNotification(prayerTimes!.dhuhr, 'صلاة الظهر', 2);
      await _scheduleNotification(prayerTimes!.asr, 'صلاة العصر', 3);
      await _scheduleNotification(prayerTimes!.maghrib, 'صلاة المغرب', 4);
      await _scheduleNotification(prayerTimes!.isha, 'صلاة العشاء', 5);
    }
  }

  Future<void> _scheduleNotification(
      DateTime prayerTime, String prayerName, int id) async {
    final scheduledTime = _nextInstanceOfTime(prayerTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'وقت الصلاة',
      prayerName,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Notifications',
          channelDescription: 'تنبيهات لأوقات الصلاة',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(DateTime prayerTime) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      prayerTime.hour,
      prayerTime.minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _selectCity() async {
    final city = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectCityPage()),
    );

    if (city != null) {
      setState(() {
        selectedCity = city;
        coordinates = Coordinates(city.lat, city.lng);
        _saveSelectedCity(city); // Save the selected city
        _loadPrayerTimes(); // Reload prayer times with the new city
      });
    }
  }

  // Format time to "HH:mm"
  String formatTime(DateTime time) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _selectCity,
          ),
        ],
      ),
      body: prayerTimes == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                if (selectedCity != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'المدينة: ${selectedCity!.name}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ListTile(
                  title: const Text('الفجر'),
                  subtitle: Text(formatTime(prayerTimes!.fajr)),
                ),
                ListTile(
                  title: const Text('الظهر'),
                  subtitle: Text(formatTime(prayerTimes!.dhuhr)),
                ),
                ListTile(
                  title: const Text('العصر'),
                  subtitle: Text(formatTime(prayerTimes!.asr)),
                ),
                ListTile(
                  title: const Text('المغرب'),
                  subtitle: Text(formatTime(prayerTimes!.maghrib)),
                ),
                ListTile(
                  title: const Text('العشاء'),
                  subtitle: Text(formatTime(prayerTimes!.isha)),
                ),
              ],
            ),
    );
  }
}

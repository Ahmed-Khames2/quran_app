import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adhan/adhan.dart';
import 'package:theam_mood_with_block/cubitss/prayer_cubit/prayer_stare.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
import 'package:theam_mood_with_block/feature/prayer_time/services/prayer_time_service.dart';
import 'package:theam_mood_with_block/main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PrayerCubit extends Cubit<PrayerState> {
  late PrayerTimeService prayerTimeService;
  late Coordinates coordinates;

  PrayerCubit() : super(PrayerState(isLoading: true)) {
    loadSelectedCity(); // Load the selected city as soon as the cubit is initialized
  }

  // Load the saved city (if any) or use default city (Cairo)
  void loadSelectedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final cityName = prefs.getString('selectedCity');
    final cityLat = prefs.getDouble('cityLat');
    final cityLng = prefs.getDouble('cityLng');

    if (cityName != null && cityLat != null && cityLng != null) {
      final city = CityModel(name: cityName, lat: cityLat, lng: cityLng);
      coordinates = Coordinates(cityLat, cityLng);
      _loadPrayerTimes(city);
    } else {
      // Default city is Cairo if no city is saved
      final defaultCity = CityModel(name: "Cairo", lat: 31.2001, lng: 29.9187);
      coordinates = Coordinates(defaultCity.lat, defaultCity.lng);
      _loadPrayerTimes(defaultCity);
    }
  }

  // Load prayer times based on city coordinates
  void _loadPrayerTimes(CityModel city) async {
    try {
      prayerTimeService = PrayerTimeService(coordinates);
      final now = DateTime.now();
      final prayerTimes = prayerTimeService.getPrayerTimes(now);
      emit(state.copyWith(prayerTimes: prayerTimes, selectedCity: city, isLoading: false));
      _schedulePrayerTimes(prayerTimes);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Error loading prayer times: $e'));
    }
  }

  // Schedule notifications for each prayer time
  void _schedulePrayerTimes(PrayerTimes prayerTimes) async {
    await _scheduleNotification(prayerTimes.fajr, 'صلاة الفجر', 1);
    await _scheduleNotification(prayerTimes.dhuhr, 'صلاة الظهر', 2);
    await _scheduleNotification(prayerTimes.asr, 'صلاة العصر', 3);
    await _scheduleNotification(prayerTimes.maghrib, 'صلاة المغرب', 4);
    await _scheduleNotification(prayerTimes.isha, 'صلاة العشاء', 5);
  }

  // Schedule a notification at the correct time
  Future<void> _scheduleNotification(DateTime prayerTime, String prayerName, int id) async {
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

  // Calculate the next instance of the prayer time (next day if the time has passed)
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

  // Save the selected city to SharedPreferences and load prayer times for the new city
  void saveSelectedCity(CityModel city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city.name);
    await prefs.setDouble('cityLat', city.lat);
    await prefs.setDouble('cityLng', city.lng);

    // After saving the city, load prayer times based on the new city
    coordinates = Coordinates(city.lat, city.lng);
    _loadPrayerTimes(city);
  }

  // Add updateCity method to update city and prayer times
  void updateCity(CityModel newCity) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', newCity.name);
    await prefs.setDouble('cityLat', newCity.lat);
    await prefs.setDouble('cityLng', newCity.lng);

    // After updating city in shared preferences, update prayer times
    coordinates = Coordinates(newCity.lat, newCity.lng);
    _loadPrayerTimes(newCity);
  }
}

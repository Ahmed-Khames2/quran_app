import 'package:adhan/adhan.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';

class PrayerState {
  final PrayerTimes? prayerTimes;
  final CityModel? selectedCity;
  final bool isLoading;
  final String? error;
  final String? currentPrayerName; // اسم الصلاة الحالية
  final DateTime? currentPrayerTime; // وقت الصلاة الحالية
  final String? remainingTime;

  PrayerState({
    this.prayerTimes,
    this.selectedCity,
    this.isLoading = true,
    this.error,
    this.currentPrayerName,
    this.currentPrayerTime,
    this.remainingTime,
  });

  PrayerState copyWith({
    PrayerTimes? prayerTimes,
    CityModel? selectedCity,
    bool? isLoading,
    String? error,
    String? currentPrayerName,
    DateTime? currentPrayerTime,
    String? remainingTime,
  }) {
    return PrayerState(
      prayerTimes: prayerTimes ?? this.prayerTimes,
      selectedCity: selectedCity ?? this.selectedCity,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPrayerName: currentPrayerName ?? this.currentPrayerName,
      currentPrayerTime: currentPrayerTime ?? this.currentPrayerTime,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}

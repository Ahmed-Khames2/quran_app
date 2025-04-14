import 'package:adhan/adhan.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';
// import '../../models/city_model.dart';

class PrayerState {
  final PrayerTimes? prayerTimes;
  final CityModel? selectedCity;
  final bool isLoading;
  final String? error;

  PrayerState({
    this.prayerTimes,
    this.selectedCity,
    this.isLoading = true,
    this.error,
  });

  PrayerState copyWith({
    PrayerTimes? prayerTimes,
    CityModel? selectedCity,
    bool? isLoading,
    String? error,
  }) {
    return PrayerState(
      prayerTimes: prayerTimes ?? this.prayerTimes,
      selectedCity: selectedCity ?? this.selectedCity,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

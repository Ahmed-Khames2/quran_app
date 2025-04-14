// Abstract class representing different states
import 'package:adhan/adhan.dart';
import 'package:theam_mood_with_block/feature/prayer_time/models/city_model.dart';

abstract class PrayerState {}

// Initial state before any action
class PrayerInitial extends PrayerState {}

// State when data is being loaded
class PrayerLoading extends PrayerState {}

// State when the location is successfully loaded
class LocationLoaded extends PrayerState {
  final Coordinates coordinates;

  LocationLoaded(this.coordinates);
}

// State when prayer times are successfully loaded
class PrayerTimesLoaded extends PrayerState {
  final PrayerTimes prayerTimes;

  PrayerTimesLoaded(this.prayerTimes);
}

// State when cities are successfully loaded
class CitiesLoaded extends PrayerState {
  final List<CityModel> cities;

  CitiesLoaded(this.cities);
}

// State when there is an error
class PrayerError extends PrayerState {
  final String message;

  PrayerError(this.message);
}

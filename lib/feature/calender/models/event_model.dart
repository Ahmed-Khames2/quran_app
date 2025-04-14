class EventModel {
  final String title;
  final int? hijriDay;
  final int? hijriMonth;
  final int? gregorianDay;
  final int? gregorianMonth;

  EventModel({
    required this.title,
    this.hijriDay,
    this.hijriMonth,
    this.gregorianDay,
    this.gregorianMonth,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'],
      hijriDay: json['hijri_day'],
      hijriMonth: json['hijri_month'],
      gregorianDay: json['gregorian_day'],
      gregorianMonth: json['gregorian_month'],
    );
  }
}

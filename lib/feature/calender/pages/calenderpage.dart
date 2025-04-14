import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:theam_mood_with_block/feature/calender/models/event_model.dart';
import 'package:theam_mood_with_block/feature/calender/service/event_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime focusedDay = DateTime.now();
  late Future<List<EventModel>> events;
  List<EventModel> allEvents = [];

  @override
  void initState() {
    super.initState();
    events = EventService.loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التقويم')),
      body: FutureBuilder<List<EventModel>>(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }

          allEvents = snapshot.data ?? [];

          return Column(
            children: [
              TableCalendar(
                locale: 'ar_EG',
                focusedDay: focusedDay,
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.saturday,
                onPageChanged: (date) {
                  setState(() {
                    focusedDay = date;
                  });
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    final arabicDays = [
                      'السبت',
                      'الأحد',
                      'الإثنين',
                      'الثلاثاء',
                      'الأربعاء',
                      'الخميس',
                      'الجمعة'
                    ];
                    return Center(
                      child: Text(
                        arabicDays[day.weekday % 7],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    final hijri = HijriCalendar.fromDate(day);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${day.day}',
                            style: const TextStyle(fontSize: 16)),
                        Text(
                          '${hijri.hDay}/${hijri.hMonth} هـ',
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'مناسبات شهر ${focusedDay.month}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView(
                  children: _getEventsForMonth(focusedDay.month).map((event) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(event.title),
                        subtitle: Text(
                          'التاريخ الميلادي: ${event.gregorianDay}/${event.gregorianMonth}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<EventModel> _getEventsForMonth(int month) {
    return allEvents.where((event) {
      return event.gregorianMonth == month;
    }).toList();
  }

  HijriCalendar _getHijriFromEvent(EventModel event) {
    if (event.gregorianDay != null && event.gregorianMonth != null) {
      final now = DateTime.now();
      final date =
          DateTime(now.year, event.gregorianMonth!, event.gregorianDay!);
      return HijriCalendar.fromDate(date);
    }
    return HijriCalendar.now();
  }
}

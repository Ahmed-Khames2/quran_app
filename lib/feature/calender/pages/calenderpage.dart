import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hijri/hijri_calendar.dart';

class IslamicCalendarPage extends StatefulWidget {
  const IslamicCalendarPage({Key? key}) : super(key: key);

  @override
  State<IslamicCalendarPage> createState() => _IslamicCalendarPageState();
}

class _IslamicCalendarPageState extends State<IslamicCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/events.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    Map<DateTime, List<String>> loadedEvents = {};

    for (var event in jsonData) {
      DateTime? date;

      // Gregorian event
      if (event.containsKey('gregorian_day') &&
          event.containsKey('gregorian_month')) {
        final now = DateTime.now();
        date = DateTime(
            now.year, event['gregorian_month'], event['gregorian_day']);
      }

      // Hijri event
      else if (event.containsKey('hijri_day') &&
          event.containsKey('hijri_month')) {
        final nowHijri = HijriCalendar.now();
        final hijri = HijriCalendar()
          ..hYear = nowHijri.hYear
          ..hMonth = event['hijri_month']
          ..hDay = event['hijri_day'];
        date = hijri.hijriToGregorian(hijri.hYear, hijri.hMonth, hijri.hDay);
      }

      if (date != null) {
        final normalized = DateTime(date.year, date.month, date.day);
        loadedEvents.update(
            normalized, (existing) => [...existing, event['title']],
            ifAbsent: () => [event['title']]);
      }
    }

    setState(() {
      _events = loadedEvents;
    });
  }

  List<String> _getEventsForDay(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return _events[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقويم والمناسبات الإسلامية'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ar',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final hijri = HijriCalendar.fromDate(day);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${hijri.hDay}ه‍',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                );
              },
              todayBuilder: (context, day, focusedDay) {
                final hijri = HijriCalendar.fromDate(day);
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${hijri.hDay}',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                final hijri = HijriCalendar.fromDate(day);
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 145, 150),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${hijri.hDay}',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    top: 8,
                    right: 13,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _getEventsForDay(_selectedDay!).isEmpty
                ? const Center(child: Text('لا توجد مناسبات في هذا اليوم'))
                : ListView.builder(
                    itemCount: _getEventsForDay(_selectedDay!).length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.event),
                        title: Text(_getEventsForDay(_selectedDay!)[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

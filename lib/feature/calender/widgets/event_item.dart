import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventItem extends StatelessWidget {
  final EventModel event;
  final String formattedDate;

  const EventItem({super.key, required this.event, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(formattedDate),
    );
  }
}

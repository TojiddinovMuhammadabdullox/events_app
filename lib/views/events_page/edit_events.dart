import 'package:events_app/models/event.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatelessWidget {
  final Event event;

  const EditEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your edit event screen here
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event'),
      ),
      body: Center(
        child: Text('Edit event: ${event.name}'),
      ),
    );
  }
}

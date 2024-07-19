import 'package:flutter/material.dart';
import 'package:events_app/models/event.dart';

class BookEvents extends StatelessWidget {
  final Event event;

  const BookEvents({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Register for ${event.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

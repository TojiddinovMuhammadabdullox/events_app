import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String name;
  final String date;
  final String time;
  final String description;
  final String mediaUrl;
  final String? location;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    required this.mediaUrl,
    this.location,
  });

  factory Event.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Event(
      id: doc.id,
      name: data?['name'] ?? '',
      date: data?['date'] ?? '',
      time: data?['time'] ?? '',
      description: data?['description'] ?? '',
      mediaUrl: data?['mediaUrl'] ?? '',
      location: data != null && data.containsKey('location')
          ? data['location']
          : null,
    );
  }

  get organizer => null;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'description': description,
      'mediaUrl': mediaUrl,
      'location': location,
    };
  }
}

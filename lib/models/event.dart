import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String name;
  final String date;
  final String time;
  final String description;
  final String mediaUrl;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    required this.mediaUrl,
  });

  factory Event.fromDocument(DocumentSnapshot doc) {
    return Event(
      id: doc.id,
      name: doc['name'],
      date: doc['date'],
      time: doc['time'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'description': description,
      'mediaUrl': mediaUrl,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/models/event.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addEvent(Event event) async {
    await _db.collection('events').add(event.toMap());
  }

  Stream<List<Event>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Event.fromDocument(doc)).toList());
  }

  Future<void> deleteEvent(String eventId) async {
    await _db.collection('events').doc(eventId).delete();
  }
}

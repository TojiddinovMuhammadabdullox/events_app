import 'package:events_app/models/event.dart';
import 'package:events_app/providers/favorites_provider.dart';
import 'package:events_app/services/firestore_service.dart';
import 'package:events_app/views/events_page/edit_events.dart';
import 'package:events_app/views/events_page/event_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListView extends StatelessWidget {
  final List<Event> events;
  final FirestoreService firestoreService;

  const EventListView({
    super.key,
    required this.events,
    required this.firestoreService,
  });

  void _editEvent(BuildContext context, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditEventScreen(event: event),
      ),
    );
  }

  void _deleteEvent(BuildContext context, Event event) async {
    await firestoreService.deleteEvent(event.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${event.name} has been deleted')),
    );
  }

  String _truncateText(String text) {
    final words = text.split(' ');
    if (words.length > 2) {
      return '${words[0]} ${words[1]}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        Event event = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EventDetails(event: event),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey, width: 4),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(event.mediaUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _truncateText(event.name),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${event.time} ${event.date}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _truncateText(event.description),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (event.location != null)
                            Text(
                              _truncateText(event.location!),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editEvent(context, event);
                      } else if (value == 'delete') {
                        _deleteEvent(context, event);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Delete'}
                          .map((String choice) => PopupMenuItem<String>(
                                value: choice.toLowerCase(),
                                child: Text(choice),
                              ))
                          .toList();
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, child) {
                      final isFavorit = favoritesProvider.isFavorite(event);
                      return IconButton(
                        onPressed: () {
                          favoritesProvider.toggleFavorite(event);
                        },
                        icon: Icon(
                          CupertinoIcons.heart_circle_fill,
                          color: isFavorit ? Colors.red : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

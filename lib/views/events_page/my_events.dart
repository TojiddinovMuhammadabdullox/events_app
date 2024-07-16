import 'package:events_app/views/events_page/add_event.dart';
import 'package:events_app/views/events_page/all_events.dart';
import 'package:events_app/views/events_page/canceled_events.dart';
import 'package:events_app/views/events_page/near_events.dart';
import 'package:events_app/views/events_page/participated_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEvents extends StatelessWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Events'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Events'),
              Tab(text: 'Near Events'),
              Tab(text: 'Participated'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllEventsTab(),
            const NearEvents(),
            const ParticipatedEvents(),
            const CanceledEvents(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (ctx) => const AddEvents()),
            );
          },
        ),
      ),
    );
  }
}

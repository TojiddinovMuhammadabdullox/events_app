import 'package:easy_localization/easy_localization.dart';
import 'package:events_app/models/event.dart';
import 'package:events_app/services/firestore_service.dart';
import 'package:events_app/views/main.pages/notification_page.dart';
import 'package:events_app/views/widgets/app_drawer.dart';
import 'package:events_app/views/widgets/custom_carousel.dart';
import 'package:events_app/views/widgets/events_listview.dart';
import 'package:events_app/views/widgets/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _searchController = TextEditingController();
  List<Event> _allEvents = [];
  List<Event> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _firestoreService.getEvents().listen((events) {
      setState(() {
        _allEvents = events;
        _filteredEvents = events;
      });
    });
  }

  void _filterEvents() {
    setState(() {
      _filteredEvents = _allEvents
          .where((event) => event.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          "bosh_sahifa".tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (ctx) => const NotificationPage()));
            },
            icon: Image.asset(
              "assets/icons/notif_icon.png",
              width: 25,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              controller: _searchController,
              onSearchChanged: _filterEvents,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "yaqin_7_kun_ichida".tr(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const CustomCarouselSlider(),
            ),
            _filteredEvents.isEmpty
                ? const Center(child: Text('No events found'))
                : EventListView(
                    events: _filteredEvents,
                    firestoreService: _firestoreService,
                  ),
          ],
        ),
      ),
    );
  }
}

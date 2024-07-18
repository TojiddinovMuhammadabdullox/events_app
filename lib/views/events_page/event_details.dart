import 'package:easy_localization/easy_localization.dart';
import 'package:events_app/views/events_page/favorit_page.dart';
import 'package:events_app/views/widgets/orange_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:events_app/models/event.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:geocoding/geocoding.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  PlacemarkMapObject? _placemarkMapObject;

  @override
  void initState() {
    super.initState();
    _setPlacemark();
  }

  Future<void> _setPlacemark() async {
    if (widget.event.location != null) {
      List<Location> locations =
          await locationFromAddress(widget.event.location!);
      if (locations.isNotEmpty) {
        setState(() {
          _placemarkMapObject = PlacemarkMapObject(
            mapId: const MapObjectId('event_location'),
            point: Point(
              latitude: locations.first.latitude,
              longitude: locations.first.longitude,
            ),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    'assets/icons/location.png'),
                scale: 0.2,
              ),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.event.mediaUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined,
                          color: Colors.white, size: 35),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (ctx) => const FavoritPage(),
                          ),
                        );
                      },
                      icon: const Icon(CupertinoIcons.heart_circle_fill,
                          color: Colors.white, size: 40),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Card(
                      color: Color(0xffDFEBEB),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.calendar_month, size: 24),
                      ),
                    ),
                    title: const Text("eslatma_kuni").tr(),
                    subtitle: Text(widget.event.date.split('T')[0]),
                  ),
                  ListTile(
                    leading: const Card(
                      color: Color(0xffDFEBEB),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.location_on, size: 24),
                      ),
                    ),
                    title: const Text("Event Location"),
                    subtitle: Text(widget.event.location ?? "N/A"),
                  ),
                  ListTile(
                    leading: const Card(
                      color: Color(0xffDFEBEB),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.person, size: 24),
                      ),
                    ),
                    title: const Text("Organizer"),
                    subtitle: Text(widget.event.organizer ?? "N/A"),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Color(0xffF2F2F2),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alisher Zokirov",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Tadbir tashkilotchisis"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Tadbir haqida",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(widget.event.description),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Manzil",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(widget.event.location ?? "N/A"),
            ),
            Container(
              height: 300,
              child: _placemarkMapObject != null
                  ? YandexMap(
                      mapObjects: [_placemarkMapObject!],
                      onMapCreated: (YandexMapController controller) {
                        controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: _placemarkMapObject!.point,
                              zoom: 14.0,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("Location not available"),
                    ),
            ),
            OrangeButton(onTap: () {}, buttonText: "Register")
          ],
        ),
      ),
    );
  }
}

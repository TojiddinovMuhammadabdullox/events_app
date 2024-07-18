import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapWidget extends StatefulWidget {
  final Function(String) onLocationUpdated;
  const MapWidget({required this.onLocationUpdated, super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late YandexMapController _controller;
  double _zoom = 10.0;
  String _currentAddress = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
          zoom: _zoom,
        ),
      ),
      animation:
          const MapAnimation(type: MapAnimationType.smooth, duration: 0.9),
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _currentAddress = placemarks.first.locality ?? 'Unknown location';
    });

    widget.onLocationUpdated(_currentAddress);
  }

  void _zoomIn() {
    setState(() {
      _zoom += 1;
      _controller.moveCamera(
        CameraUpdate.zoomIn(),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.9),
      );
    });
  }

  void _zoomOut() {
    setState(() {
      _zoom -= 1;
      _controller.moveCamera(
        CameraUpdate.zoomOut(),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.9),
      );
    });
  }

  void _centerToUserLocation() async {
    await _getCurrentLocation();
  }

  PlacemarkMapObject? _placemarkMapObject;

  Future<void> _onMapLongTap(Point argument) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(argument.latitude, argument.longitude);
    setState(() {
      _currentAddress = placemarks.first.locality ?? 'Unknown location';
      _placemarkMapObject = PlacemarkMapObject(
        mapId: const MapObjectId('event_location'),
        point: argument,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/icons/location.png'),
            scale: 0.2,
          ),
        ),
      );
    });
    widget.onLocationUpdated(_currentAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          child: YandexMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            mapObjects:
                _placemarkMapObject != null ? [_placemarkMapObject!] : [],
            onMapTap: (Point point) {},
            zoomGesturesEnabled: true,
            onMapLongTap: _onMapLongTap,
            onMapCreated: (YandexMapController controller) {
              _controller = controller;
            },
          ),
        ),
        Text("Current Location: $_currentAddress"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: _zoomIn,
              icon: const Icon(Icons.zoom_in),
            ),
            IconButton(
              onPressed: _centerToUserLocation,
              icon: const Icon(
                Icons.location_on_rounded,
                color: Colors.amber,
              ),
            ),
            IconButton(
              onPressed: _zoomOut,
              icon: const Icon(Icons.zoom_out),
            )
          ],
        ),
      ],
    );
  }
}

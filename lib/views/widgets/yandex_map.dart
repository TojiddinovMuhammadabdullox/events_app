import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomYandexMap extends StatefulWidget {
  const CustomYandexMap({super.key});

  @override
  _CustomYandexMapState createState() => _CustomYandexMapState();
}

class _CustomYandexMapState extends State<CustomYandexMap> {
  late YandexMapController _controller;
  final List<MapObject> _mapObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController controller) {
              _controller = controller;
            },
            mapObjects: _mapObjects,
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: Icon(Icons.zoom_in),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: Icon(Icons.zoom_out),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _getCurrentLocation,
                  child: Icon(Icons.my_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _zoomIn() {
    _controller.moveCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _controller.moveCamera(CameraUpdate.zoomOut());
  }

  void _getCurrentLocation() async {
    if (await Permission.location.request().isGranted) {
      var cameraPosition = await _controller.getCameraPosition();
      if (cameraPosition != null) {
        var userLocation = cameraPosition.target;

        var placemark = PlacemarkMapObject(
          mapId: MapObjectId('user_location'),
          point: userLocation,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image:
                  BitmapDescriptor.fromAssetImage("assets/icons/location.png"),
              scale: 0.2,
            ),
          ),
        );

        setState(() {
          _mapObjects.add(placemark);
        });

        _controller.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: userLocation,
              zoom: 16,
            ),
          ),
          animation:
              const MapAnimation(type: MapAnimationType.smooth, duration: 2.0),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permission is required to show your current location'),
        ),
      );
    }
  }
}

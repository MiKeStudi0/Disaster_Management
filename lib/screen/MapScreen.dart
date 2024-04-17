import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller;
  static const LatLng _center = LatLng(11.43838308285179, 75.76443871028839);
  LatLng? _currentPosition;
  late double _heading = 0;
  List<LatLng> _polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getHeading();
  }

  Future<void> _getHeading() async {
    final compassStream = FlutterCompass.events;
    compassStream?.listen((event) {
      setState(() {
        _heading = event.heading ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        onTap: _updateCurrentPosition,
        markers: {
          if (_currentPosition != null)
            Marker(
              markerId: MarkerId('Current Position'),
              position: _currentPosition!,
            ),
          Marker(
            markerId: MarkerId('Rescue Camp'),
            icon: BitmapDescriptor.defaultMarker,
            position: _center,
            infoWindow: InfoWindow(
              title: 'Rescue Camp',
              snippet: 'Kozhikode',
            ),
          ),
        },
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        polylines: {
          if (_polylineCoordinates.isNotEmpty)
            Polyline(
              polylineId: PolylineId('path'),
              color: Colors.blue,
              points: _polylineCoordinates,
            ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentPosition != null) {
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _center,
                  zoom: 15,
                  bearing: _calculateBearing(),
                ),
              ),
            );
            _updatePolyline();
          }
        },
        child: Icon(Icons.directions),
      ),
    );
  }

  void _updateCurrentPosition(LatLng position) {
    setState(() {
      _currentPosition = position;
    });
  }

  void _updatePolyline() {
    if (_currentPosition != null) {
      setState(() {
        _polylineCoordinates.clear();
        _polylineCoordinates.add(_currentPosition!);
        _polylineCoordinates.add(_center);
      });
    }
  }

  double _calculateBearing() {
    if (_currentPosition == null) return 0;
    double lat1 = _currentPosition!.latitude * math.pi / 180.0;
    double lon1 = _currentPosition!.longitude * math.pi / 180.0;
    double lat2 = _center.latitude * math.pi / 180.0;
    double lon2 = _center.longitude * math.pi / 180.0;

    double dLon = lon2 - lon1;
    double y = math.sin(dLon) * math.cos(lat2);
    double x = math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    double bearing = math.atan2(y, x);
    return (bearing >= 0) ? bearing : (2 * math.pi + bearing);
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}

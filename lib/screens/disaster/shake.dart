import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShakeLocationPage extends StatefulWidget {
  @override
  _ShakeLocationPageState createState() => _ShakeLocationPageState();
}

class _ShakeLocationPageState extends State<ShakeLocationPage> {
  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      _sendLocationToFirebase();
      _showSOSAlert();
    });
  }

  Future<void> _sendLocationToFirebase() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference locations = firestore.collection('locations');
      await locations.add({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': DateTime.now(),
      });
      print(
          'Location sent to Firebase: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error sending location: $e');
    }
  }

  Future<void> _showSOSAlert() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SOS Alert'),
          content: Text('Emergency! Send help immediately!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shake Location'),
      ),
      body: Center(
        child: Text(
          'Shake your phone to send your location to Firebase.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

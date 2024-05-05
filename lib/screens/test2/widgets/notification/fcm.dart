import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FCM Token Example',
      home: FCMTokenReceiver(),
    );
  }
}

class FCMTokenReceiver extends StatefulWidget {
  const FCMTokenReceiver({super.key});

  @override
  _FCMTokenReceiverState createState() => _FCMTokenReceiverState();
}

class _FCMTokenReceiverState extends State<FCMTokenReceiver> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _fcmToken = '';

  @override
  void initState() {
    super.initState();
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    await _firebaseMessaging.requestPermission();
    String token = await _firebaseMessaging.getToken() ?? 'No token found';
    setState(() {
      _fcmToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Token'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('FCM Token: $_fcmToken'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getFCMToken,
              child: const Text('Refresh Token'),
            ),
          ],
        ),
      ),
    );
  }
}

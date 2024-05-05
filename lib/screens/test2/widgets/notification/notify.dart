import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firestore Notifications',
      home: NotificationSender(),
    );
  }
}

class NotificationSender extends StatefulWidget {
  const NotificationSender({super.key});

  @override
  _NotificationSenderState createState() => _NotificationSenderState();
}

class _NotificationSenderState extends State<NotificationSender> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to send notification
  Future<void> sendNotification(String token, String message) async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken();
    await _firebaseMessaging.subscribeToTopic('all');
    await _firebaseMessaging.sendMessage(
      to: token,
      data: <String, String>{
        'title': 'Notification',
        'body': message,
      },
    );
  }

  // Function to get users from Firestore based on criteria
  Future<List<String>> getUsersToNotify() async {
    // Example query: Get users where 'notify' field is true
    QuerySnapshot snapshot = await _firestore.collection('Users').where('notify', isEqualTo: true).get();
    List<String> tokens = [];
    for (var doc in snapshot.docs) {
      tokens.add(doc['fcmToken']);
    }
    return tokens;
  }

  // Function to send notifications to selected users
  void sendNotifications() async {
    List<String> tokens = await getUsersToNotify();
    tokens.forEach((token) async {
      await sendNotification(token, 'This is a notification message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendNotifications,
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}

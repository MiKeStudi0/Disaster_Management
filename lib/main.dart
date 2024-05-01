import 'package:disaster_management/authservices/authenticate.dart';
import 'package:disaster_management/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFCMToken() async {
  // Request permission to receive notifications
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // Get the token
    String? token = await FirebaseMessaging.instance.getToken();
    return(token) ;
  } else {
    print('User has not granted permission to receive notifications.');
    return null;
  }
}




void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   String? fcmToken = await getFCMToken();
  if (fcmToken != null) {
    print('FCM Token: $fcmToken');
  } else {
    print('Failed to retrieve FCM token.');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


import 'package:disaster_management/authservices/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import 'package:disaster_management/utils/helpers/helper_functions.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  String? mtoken = "";
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<String?> fetchEligibility(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          (await FirebaseFirestore.instance.collection('Users').doc(uid).get());
      if (snapshot.exists) {
        final String isEligible = snapshot.data()?['Eligible'];
        return isEligible;
      } else {
        await FirebaseFirestore.instance.collection("Users").doc(uid).set({
          'Eligible': 'false',
        });
        return 'false';
      }
    } catch (e) {
      print("Error for eligibility");
      return 'false';
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User permission granted");
      getToken();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Provisional status given");
    } else {
      print("User permission for notification not given");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          mtoken = token;
          print("My token is $mtoken");
        });
        saveToken(token!);
      },
    );
  }

  void saveToken(String token) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userSnapshot.exists) {
        final String? bloodGroup = userSnapshot.data()?['BloodGroup'];
        final String? city = userSnapshot.data()?['City'];

        if (bloodGroup != null) {
          await FirebaseFirestore.instance.collection("tokens").doc(uid).set({
            'token': token,
            'bloodgroup': bloodGroup,
            'City': city,
          });
          print("Token and blood group saved successfully");
        } else {
          print("Blood group not found for user with UID: $uid");
        }
      } else {
        print("User document not found for UID: $uid");
      }
    } catch (e) {
      print("Error fetching blood group: $e");
    }
  }
  // void handleNotification(RemoteMessage? message) {
  //   if (message == null) return;
  //   navigatorKey.currentState
  //       ?.pushNamed('handle_notification', arguments: message);
  // }

  // Future initPushNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     if (message != null) {
  //       handleNotification(message);
  //     }
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  // }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return const  Scaffold(
        body: AuthPage());
  }
}
import 'package:disaster_management/screens/bloodbank/bbankscreen.dart';
import 'package:disaster_management/screens/eligibility/eligibilityScreen.dart';
import 'package:disaster_management/screens/nearby/nearby_screen.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:disaster_management/screens/homescreens/widget/home_appbar.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';

import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen3> {
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

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        const TPrimaryHeaderContainer(
            child: Column(
          children: [
            THomeAppBar(),
            Padding(
                padding: EdgeInsets.all(TSizes.md),
                child: TPromoSlider(
                  banners: [
                    TImages.promoBanner3,
                  ],
                )),
          ],
        )),
        const SizedBox(
          height: TSizes.sm,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eligibilitycheck(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () => Get.to(() => const NearbyScreen()),
                child: Container(
                  width: 330,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 0, 0),
                      width: 0.4,
                    ),
                    color: dark ? TColors.darkerGrey : const Color(0xFFF6F6F6),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x17000000),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/content/blood-drop.png',
                        width: 60,
                        height: 60,
                      )),
                      Text(
                        'Nearby Donors',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: dark ? TColors.textWhite : TColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Bbankscreen()));
              },
              child: Center(
                child: Container(
                  width: 330,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 0, 0),
                      width: 0.4,
                    ),
                    color: dark ? TColors.darkerGrey : const Color(0xFFF6F6F6),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x17000000),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/content/blood-banks.png',
                        width: 60,
                        height: 60,
                      )),
                      Text(
                        'Blood Banks',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: dark ? TColors.textWhite : TColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
  }

  GestureDetector eligibilitycheck() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EligibilityScreen()));
      },
      child: FutureBuilder<String?>(
        future: fetchEligibility(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          String? isEligible = snapshot.data;
          if (isEligible == null) {
            return const SizedBox();
          } else {
            return Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 6, 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isEligible == 'true'
                    ? const Color(0xFF64F472) // Green color
                    : const Color(0xFFFF6464), // Red color
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x17000000),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: TSizes.md),
                child: Container(
                  width: 340,
                  padding: const EdgeInsets.fromLTRB(19, 7, 14, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 1, 9, 1),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            isEligible == 'true'
                                ? 'You’re eligible to Donate'
                                : 'Not eligible to Donate',
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          isEligible == 'true'
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: const Color(0xFFFFFFFF),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

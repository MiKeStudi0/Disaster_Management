import 'dart:convert';

import 'package:disaster_management/common/appbar.dart';
import 'package:disaster_management/common/shimmer_effect.dart';
import 'package:disaster_management/screens/donor/donor_controller.dart';
import 'package:disaster_management/screens/donor/requestallScreen.dart';
import 'package:disaster_management/screens/donor/textblock.dart';
import 'package:disaster_management/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_management/screens/receiver_screen/receiver_controller.dart';
import 'package:disaster_management/utils/constants/image_strings.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class DonorScreen extends StatefulWidget {
  const DonorScreen({Key? key}) : super(key: key);

  @override
  State<DonorScreen> createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {

  final  RequestController controllerzz= Get.put(RequestController());
@override
  void initState() {
    getCurrentUserId();
    // TODO: implement initState
    super.initState();
  }
String usermy = 'hai';
void getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
     usermy = user.uid;
    print('Current user ID: $usermy');
  } else {
    print('No user signed in.');
  }
}


  Future<String?> getTokenFromFirestore(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('tokens')
              .doc(userId)
              .get();

      if (snapshot.exists) {
        final token = snapshot.data()?['token'];
        return token;
      } else {
        print('Token not found for user with ID: $userId');
        return null;
      }
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  Future<String?> getname(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    final name = snapshot.data()?['FirstName'];

    return name;
  }

  Future<void> handleRequestButtonTap(
    BuildContext context, {
    required String userID,
    required Map<String, dynamic> userData,
    required String currentUserId,
  }) async {
    final confirmed = await _showConfirmationDialog(context);

    if (confirmed) {
      try {
        await _sendRequest(userID, userData);
        await _sendRequestWaiting(currentUserId, userData);
               controllerzz.fetchData();
    controllerzz.fetchDataAccepted();
    controllerzz.fetchDataConfrimed();
    controllerzz.fetchDataWaiting();
    controllerzz.fetchDataRequest();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request sent successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending request: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Request'),
              content: const Text(
                  'Are you sure you want to send a request to this donor?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true if confirmed
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Return false if canceled
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }

  Future<void> _sendRequest(
      String userID, Map<String, dynamic> userData) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    // Get a reference to the collection
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    final String? bloodGroup = userSnapshot.data()?['BloodGroup'];
    final String? city = userSnapshot.data()?['City'];
    final String? street = userSnapshot.data()?['Street'];
    final String? gender = userSnapshot.data()?['Gender'];
    final String? phoneNumber = userSnapshot.data()?['PhoneNumber'];
    final int age = userSnapshot.data()?['Age'];
    final String? email = userSnapshot.data()?['Email'];
    final String? profilePicture = userSnapshot.data()?['ProfilePicture'];
    final String? userName = userSnapshot.data()?['UserName'];
    final String? firstName = userSnapshot.data()?['FirstName'];
    final String? lastName = userSnapshot.data()?['LastName'];
    final String? eligible = userSnapshot.data()?['Eligible'];
    print('Eligible: $eligible');
    print('BloodGroup: $bloodGroup');
    print('City: $city');
    print('Street: $street');
    print('firstName: $firstName');
    print('lastName: $lastName');


    final firestore = FirebaseFirestore.instance;

    await firestore 
        .collection('UserRequests')
        .doc(userID)
        .collection('Requests')
        .doc(usermy)
        .set({
      'FirstName': firstName,
      'LastName': lastName,
      'Street': street,
      'Gender': gender,
      'City': city,
      'PhoneNumber': phoneNumber,
      'Age': age,
      'BloodGroup': bloodGroup,
      'Email': email,
      'ProfilePicture': profilePicture,
      'UserName': userName,
      'RequesterID': usermy,
      'RequesterName': FirebaseAuth.instance.currentUser!.displayName,
      'Eligible': eligible,
    });
  }

  Future<void> _sendRequestWaiting(
      String userID, Map<String, dynamic> userData) async {
    final requesterID = userData["id"] ?? '';
    final firstName = userData["FirstName"] ?? '';
    final lastName = userData["LastName"] ?? '';
    final street = userData["Street"] ?? '';
    final gender = userData["Gender"] ?? '';
    final city = userData["City"] ?? '';
    final phoneNumber = userData["PhoneNumber"] ?? '';
    final age = userData["Age"] ?? '';
    final bloodGroup = userData["bloodGroup"] ?? '';
    final email = userData["Email"] ?? '';
    final profilePicture = userData["ProfilePicture"] ?? '';
    final userName = userData["UserName"] ?? '';
    final currentUserId = requesterID;
    final eligible = userData["Eligible"] ?? '';

    final firestore = FirebaseFirestore.instance;

    await firestore
        .collection('UserRequests')
        .doc(userID)
        .collection('WaitingRequests')
        .doc(currentUserId)
        .set({
      'FirstName': firstName,
      'LastName': lastName,
      'Street': street,
      'Gender': gender,
      'City': city,
      'PhoneNumber': phoneNumber,
      'Age': age,
      'BloodGroup': bloodGroup,
      'Email': email,
      'ProfilePicture': profilePicture,
      'UserName': userName,
      'RequesterID': currentUserId,
      'RequesterName': FirebaseAuth.instance.currentUser!.displayName,
      'Eligible': eligible,
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final DonorController controller = Get.put(DonorController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Donors List', style: TextStyle(            color: dark ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0),
)),
        leadingIcon: Icons.group_add,
        leadingOnPress: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Requestallscreen()));
        },
        leadingIconColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            // Return a loading indicator if data is still loading
            return const Center(
              child: TshimmerEffect(
                height: 260,
                width: double.infinity,
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Requestallscreen()));
                    },
                    child: const Text(
                      'Public Request',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                      itemCount: controller.userDataList
                          .where(
                              (userData) => (userData['bloodGroup'] != 'Nill'))
                          .where((userData) => (userData['Eligible'] == 'true'))
                        
                          .toList()
                          .length,
                      itemBuilder: (_, index) {
                        // Filtered userDataList excluding items with blood group 'Nill'
                        final filteredUserDataList = controller.userDataList
                            .where((userData) =>
                                (userData['bloodGroup'] != 'Nill'))
                            .where(
                                (userData) => (userData['Eligible'] == 'true'))
                        
                            .toList();

                        final bloodGroup =
                            controller.userDataList[index]['bloodGroup'] ?? '';
                        final userID =
                            controller.userDataList[index]['id'] ?? '';
                        final pushuserID =
                            controller.userDataList[index]['id'] ?? '';
                            print('pushuserID: $pushuserID');
                        final currentUserId =
                            FirebaseAuth.instance.currentUser!.uid;

                        String letter = '';
                        String sign = '';
                        if (bloodGroup.isNotEmpty) {
                          letter =
                              bloodGroup.substring(0, bloodGroup.length - 1);
                          sign = bloodGroup.substring(bloodGroup.length - 1);
                        }

                        final userData = filteredUserDataList[index];
                        final imageURl = userData['ProfilePicture'] == ''
                            ? TImages.user
                            : userData['ProfilePicture'];

                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF868484)),
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFFFFFFF),
                            ),
                            height: 260,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    const SizedBox(width: 16.0),
                                    TRoundedImage(
                                      isNetworkImage:
                                          userData['ProfilePicture'] != '',
                                      imageUrl: imageURl,
                                      height: 50,
                                      width: 50,
                                      borderRadius: 50,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Text(
                                      '${userData["FirstName"]} ${userData["LastName"]}',
                                      style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0,
                                        color: const Color(0xFF490008),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: const Color.fromRGBO(
                                                    255, 218, 218, 1),
                                              ),
                                              height: 90,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Text(
                                                          letter,
                                                          style: GoogleFonts
                                                              .lexend(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 30.0,
                                                            color: const Color(
                                                                0xFFD9214B),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: -14.0,
                                                          right: -1,
                                                          child: Text(
                                                            sign,
                                                            style: GoogleFonts
                                                                .lexend(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 24.0,
                                                              color: const Color(
                                                                  0xFFD9214B),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 16.0),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Eligibility:',
                                                          style: GoogleFonts
                                                              .lexend(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 9.0,
                                                            color: const Color(
                                                                0xFF868484),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4.0),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: userData[
                                                                        'Eligible'] ==
                                                                    'true'
                                                                ? const Color(
                                                                    0xFF32D418)
                                                                : const Color(
                                                                    0xFFD9214B),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.0),
                                                          ),
                                                          child: Text(
                                                            userData['Eligible'] ==
                                                                    'true'
                                                                ? 'Eligible'
                                                                : 'Not Eligible',
                                                            style: GoogleFonts
                                                                .lexend(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 9.0,
                                                              color: const Color(
                                                                  0xCCFFFFFF),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: TSizes.md),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextBlock(
                                                  title:
                                                      "${userData['Gender']} (${userData['Age']} Age) " ??
                                                          'Nill',
                                                  icons: Iconsax.user,
                                                ),
                                                const SizedBox(height: 8.0),
                                                TextBlock(
                                                    title:
                                                        "${userData['Street']}",
                                                    icons:
                                                        Iconsax.location_add),
                                                const SizedBox(height: 8.0),
                                                TextBlock(
                                                    title: userData['City'],
                                                    icons: Iconsax.location),
                                                const SizedBox(height: 8.0),
                                                TextBlock(
                                                    title: userData[
                                                            'PhoneNumber'] ??
                                                        'Nill',
                                                    icons: Iconsax.call_add)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                          top: 5,
                                          left: -3,
                                          child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Image.asset(
                                                  'assets/images/content/blood.png'))),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1),
                                const Divider(),
                                Row(
                                  children: [
                                    const SizedBox(width: TSizes.sm),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          final firstName =
                                              userData["FirstName"] ?? '';
                                          final lastName =
                                              userData["LastName"] ?? '';
                                          final street =
                                              userData["Street"] ?? '';
                                          final postalCode =
                                              userData["PostalCode"] ?? '';
                                          final city = userData["City"] ?? '';
                                          final phoneNumber =
                                              userData["PhoneNumber"] ?? '';

                                          final textToShare = '''
                        Contact Him/Her for Blood Donation
                        ----------------------------------
                        Donor Name: $firstName $lastName
                        Address: $street
                        PostalCode: $postalCode
                        City: $city
                        Phone Number: $phoneNumber
                      ''';

                                          Share.share(textToShare.trim());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: const Color(0xFF868484)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  Iconsax.arrow_swap_horizontal,
                                                  color: Colors.red),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                'Share',
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                  color:
                                                      const Color(0xFF868484),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          await handleRequestButtonTap(context,
                                              userID: userID,
                                              userData: userData,
                                              currentUserId: currentUserId);
                                          final token =
                                              await getTokenFromFirestore(
                                                  userID);
                                          final name =
                                              await getname(currentUserId);
                                          if (token != null) {
                                            sendPushMessage(
                                                token,
                                                "Hey ${userData['FirstName']}, Your Blood  is needed for $name",
                                                "Blood request from $name");
                                          } else {
                                            print(
                                                'Token not found for user $userID');
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: const Color.fromARGB(
                                                255, 255, 46, 46),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Iconsax.card_send,
                                                  color: Colors.white),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                'Request',
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                  color: dark
                                                      ? const Color(0xFFFFFFFF)
                                                      : const Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: TSizes.sm),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      final response =
          await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: <String, String>{
                'Content-type': 'application/json',
                'Authorization':
                    'key=AAAA2Q-gZUI:APA91bG82u-PAlLPu3KbH69rR317RPn3pYUMv-JkNd0O13lRVJH2gOC5tVLnVh_DXIRuZKn54p7ryrbPxDjfJJJXKDB7GwvxjXl_FFbffkd4nktOZDvMNe5BC3CqYd5t2LTQTG3oYtgR',
              },
              body: jsonEncode(<String, dynamic>{
                'priority': 'high',
                'data': <String, dynamic>{
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'status': 'done',
                  'body': body,
                  'title': title,
                },
                "notification": <String, dynamic>{
                  "title": title,
                  "body": body,
                },
                "to": token
              }));
      if (response.statusCode == 200) {
        print("Message send");
      } else {
        print("Error sending push notification: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in push notification");
      }
    }
  }
}

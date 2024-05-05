import 'dart:convert';

import 'package:disaster_management/screens/donor/donor_controller.dart';
import 'package:disaster_management/screens/receiver_screen/receiver_controller.dart';
import 'package:disaster_management/utils/constants/colors.dart';
import 'package:disaster_management/utils/constants/sizes.dart';
import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Requestallscreen extends StatefulWidget {
  const Requestallscreen({Key? key}) : super(key: key);

  @override
  State<Requestallscreen> createState() => _RequestallscreenState();
}

class _RequestallscreenState extends State<Requestallscreen> {
  String? selectedBloodGroup;
  String? selectedCity;
  final  RequestController controllerzz= Get.put(RequestController());
  final DonorController controller = Get.put(DonorController());
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
  
Future<void> handleRequestButtonTap(
  BuildContext context, {
  required RxList<Map<String, dynamic>> userData,
}) async {
  final confirmed = await _showConfirmationDialog(context);

  if (confirmed) {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      for (var data in userData) {
        var bloodGroup = data['bloodGroup'];
        var city = data['City'];
        print('Blood Group: $bloodGroup');
        print('City: $city');
        print('Selected Blood Group: $selectedBloodGroup');
        print('Selected City: $selectedCity');
        
        // Check if the blood group matches the selected blood group
        if (bloodGroup == selectedBloodGroup && city == selectedCity) {
          // If blood group matches, proceed with sending the request
          var userId = data['id'];
          await _sendRequest(userId, data); 
          await _sendRequestWaiting(currentUserId, data);
        }
        
      }
      
      
      // Update the data after sending requests
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
  bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Selection'),
        content: const Text('Are you sure you want to send the request?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
                sendPushMessageToBloodGroup(
                    selectedBloodGroup!, selectedCity!,
                    "This is a group notification for $selectedBloodGroup",
                    'Request made');
                print('Submitted blood group: $selectedBloodGroup');
                              Navigator.of(context).pop(true); // Return true if confirmed

            },
            child: const Text('Yes'),
            
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false if not confirmed
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );

  return result ?? false; // Return false if dialog is dismissed
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood Group'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please select your blood group and city below. Once selected, press the 'Submit' button to send a notification to all users with the same blood group and city.",
              textAlign: TextAlign.left,
              style: TextStyle(
                color:  dark ? TColors.grey : const Color.fromARGB(255, 0, 0, 0),
                
                fontSize: 16,
              ),
            ),
           const SizedBox(height: 20),
             Text(
              "Select blood Group Which is Needed",
              style: TextStyle(
                color: dark ? const Color.fromARGB(255, 255, 255, 255) : TColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
           Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: dark ? Colors.white : TColors.black, // Choose border color based on theme
    ),
  ),
  width: 300,
  child: DropdownButton<String>(
    icon: const Padding(
      padding: EdgeInsets.only(left: 230.0),
      child: Icon(Icons.arrow_drop_down),
    ),
    value: selectedBloodGroup,
    onChanged: (String? newValue) {
      setState(() {
        selectedBloodGroup = newValue;
      });
    },
    // Add padding to the dropdown menu items
    dropdownColor: dark ? TColors.black : Colors.white, // Choose dropdown menu background color based on theme
    underline: Container(), // Remove the default underline
    style: TextStyle(
      color: dark ? Colors.white : TColors.black,
    ),
    iconEnabledColor: dark ? Colors.white : TColors.black,
    items: <String>[
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0), // Adjust padding as needed
          child: Text(
            value,
            style: TextStyle(
              color: dark ? Colors.white : TColors.black,
            ),
          ),
        ),
      );
    }).toList(),
  ),
),

            const SizedBox(height: 20),
            Text(
              "Select Your City",
              style: TextStyle(
                color: dark ? const Color.fromARGB(255, 255, 255, 255) : TColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
           Container(
             decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: dark ? Colors.white : TColors.black, // Choose border color based on theme
    ),
  ),
  width: 300,
  child: DropdownButton<String>(
    icon:const Padding(
      padding:  EdgeInsets.only(left: 125.0),
      child: Icon(Icons.arrow_drop_down),
    ),
    value: selectedCity,
    onChanged: (String? newValue) {
      setState(() {
        selectedCity = newValue;
      });
    },
    // Apply padding and customize dropdown appearance
    dropdownColor: dark ? TColors.black : Colors.white, // Choose dropdown menu background color based on theme
    underline: Container(), // Remove the default underline
    style: TextStyle(
      color: dark ? Colors.white : TColors.black,
    ),
    iconEnabledColor: dark ? Colors.white : TColors.black,
    items: <String>[
      'Alappuzha',
      'Ernakulam',
      'Idukki',
      'Kannur',
      'Kasaragod',
      'Kollam',
      'Kottayam',
      'Kozhikode',
      'Malappuram',
      'Palakkad',
      'Pathanamthitta',
      'Thiruvananthapuram',
      'Thrissur',
      'Wayanad',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0), // Adjust padding as needed
          child: Text(
            value,
            style: TextStyle(
              color: dark ? Colors.white : TColors.black,
            ),
          ),
        ),
      );
    }).toList(),
  ),
),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                      handleRequestButtonTap(context,
                                            
                                              userData: controller.userDataList,
                                             );

         
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}

void sendPushMessageToBloodGroup(
    String bloodGroup, String selectedCity, String title, String body) async {
  try {
    // Query tokens collection to get tokens with the selected blood group and city
    QuerySnapshot<Map<String, dynamic>> tokenSnapshot = await FirebaseFirestore
        .instance
        .collection('tokens')
        .where('bloodgroup', isEqualTo: bloodGroup)
        .where('City', isEqualTo: selectedCity)
        .get();

    // Loop through the tokens and send push messages
    for (QueryDocumentSnapshot<Map<String, dynamic>> tokenDoc
        in tokenSnapshot.docs) {
      String uid = tokenDoc.id; // Get the uid from the document ID
      String token = tokenDoc.data()['token'];
      print(token);
      sendPushMessage(token, title, body);
    }

    print('Push messages sent successfully to blood group: $bloodGroup');
  } catch (e) {
    print('Error sending push messages: $e');
  }
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
      print("Message sent");
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

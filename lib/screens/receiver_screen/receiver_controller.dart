import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestController extends GetxController {
  static RequestController get to => Get.find();

  
  // Define an observable list to hold the fetched data
  var userDataList = <Map<String, dynamic>>[].obs;
  var userDataList2 = <Map<String, dynamic>>[].obs;
  var userDataList3 = <Map<String, dynamic>>[].obs;
  var userDataList4 = <Map<String, dynamic>>[].obs;
  var userDataList5 = <Map<String, dynamic>>[].obs;
  var userDataList6 = <Map<String, dynamic>>[].obs;
  
  // Observable boolean to track loading state
  var isLoading = false.obs;
  var isLoading2 = false.obs;
 
  @override
  void onInit() {
    super.onInit();
    // Call a function to fetch data when the controller is initialized
    fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
  }

  void fetchData() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser!.uid;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('UserRequests').doc(user).collection('Requests').get();

      // Extract the desired field values from each document
      var dataList = querySnapshot.docs.map((doc) {
        // Extract multiple fields from each document and store them in a map
        return {
                  'id': doc.id, // Include the document ID

          'ProfilePicture': doc['ProfilePicture'],
          'UserName': doc['UserName'],
          'bloodGroup': doc['BloodGroup'],
          'PhoneNumber': doc['PhoneNumber'],
          'Street': doc['Street'],
          'Gender': doc['Gender'],
          'City': doc['City'],
          'Age': doc['Age'],
          
            'Email': doc['Email'],
            'FirstName': doc['FirstName'],
            'LastName': doc['LastName'],
             'RequesterID': doc['RequesterID'],
            'RequesterName': doc['RequesterName'],
          // Add more fields as needed
            };
      }).toList();
      
      // Update the value of the observable list
      userDataList.value = dataList;
      print(userDataList);

    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }


  void fetchDataRequest() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser!.uid;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('UserRequests').doc(user).collection('Requests').get();

      // Extract the desired field values from each document
      var dataList5 = querySnapshot.docs.map((doc) {
        // Extract multiple fields from each document and store them in a map
        return {
                  'id': doc.id, // Include the document ID

          'ProfilePicture': doc['ProfilePicture'],
          'UserName': doc['UserName'],
          'bloodGroup': doc['BloodGroup'],
          'PhoneNumber': doc['PhoneNumber'],
          'Street': doc['Street'],
          'Gender': doc['Gender'],
          'City': doc['City'],
          'Age': doc['Age'],
          
            'Email': doc['Email'],
            'FirstName': doc['FirstName'],
            'LastName': doc['LastName'],
             'RequesterID': doc['RequesterID'],
            'RequesterName': doc['RequesterName'],
          // Add more fields as needed
            };
      }).toList();
      
      // Update the value of the observable list
      userDataList5.value = dataList5;
      print(userDataList);

    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }
  void fetchDataConfrimed() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser!.uid;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('SenderRequests').doc(user).collection('AcceptedRequests').get();

      // Extract the desired field values from each document
      var dataList3 = querySnapshot.docs.map((doc) {
        // Extract multiple fields from each document and store them in a map
        return {
                  'id': doc.id, // Include the document ID

          'ProfilePicture': doc['ProfilePicture'],
          'UserName': doc['UserName'],
          'bloodGroup': doc['BloodGroup'],
          'PhoneNumber': doc['PhoneNumber'],
          'Street': doc['Street'],
          'Gender': doc['Gender'],
          'City': doc['City'],
          'Age': doc['Age'],
          
            'Email': doc['Email'],
            'FirstName': doc['FirstName'],
            'LastName': doc['LastName'],
             'RequesterID': doc['RequesterID'],
          // Add more fields as needed
            };
      }).toList();
      
      // Update the value of the observable list
      userDataList3.value = dataList3;
      print(userDataList3);

    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }

  
  void fetchDataWaiting() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser!.uid;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('UserRequests').doc(user).collection('WaitingRequests').get();

      // Extract the desired field values from each document
      var dataList4 = querySnapshot.docs.map((doc) {
        // Extract multiple fields from each document and store them in a map
        return {
                  'id': doc.id, // Include the document ID

          'ProfilePicture': doc['ProfilePicture'],
          'UserName': doc['UserName'],
          'bloodGroup': doc['BloodGroup'],
          'PhoneNumber': doc['PhoneNumber'],
          'Street': doc['Street'],
          'Gender': doc['Gender'],
          'City': doc['City'],
          'Age': doc['Age'],
          
            'Email': doc['Email'],
            'FirstName': doc['FirstName'],
            'LastName': doc['LastName'],
             'RequesterID': doc['RequesterID'],
          // Add more fields as needed
            };
      }).toList();
      
      // Update the value of the observable list
      userDataList4.value = dataList4;
      print(userDataList4);

    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }
  
  
  void fetchDataAccepted() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser!.uid;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('UserRequests').doc(user).collection('AcceptedRequests').get();

      // Extract the desired field values from each document
      var dataList2 = querySnapshot.docs.map((doc) {
        // Extract multiple fields from each document and store them in a map
        return {
                  'id': doc.id, // Include the document ID

          'ProfilePicture': doc['ProfilePicture'],
          'UserName': doc['UserName'],
          'bloodGroup': doc['BloodGroup'],
          'PhoneNumber': doc['PhoneNumber'],
          'Street': doc['Street'],
          'Gender': doc['Gender'],
          'City': doc['City'],
          'Age': doc['Age'],
          
            'Email': doc['Email'],
            'FirstName': doc['FirstName'],
            'LastName': doc['LastName'],
             'RequesterID': doc['RequesterID'],
          // Add more fields as needed
            };
      }).toList();
      
      // Update the value of the observable list
      userDataList2.value = dataList2;
      print(userDataList2);

    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }
  // Method to delete a request
  Future<void> deleteRequest(String userID) async {
    try {
      fetchDataAccepted();
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('UserRequests')
          .doc(currentUserId)
          .collection('Requests')
          .doc(userID)
          .delete();
      
      // Remove the deleted request from the userDataList
      userDataList.removeWhere((userData) => userData['RequesterID'] == userID);
         fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
    } catch (e) {
      // Handle error
    }
  }

    Future<void> deletefromwaitafteraccept(String userID) async {
    try {
      fetchDataAccepted();
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('UserRequests')
          .doc(userID)
          .collection('WaitingRequests')
          .doc(currentUserId)
          .delete();
      
      // Remove the deleted request from the usserDataList
      userDataList.removeWhere((userData) => userData['RequesterID'] == userID);
         fetchData();

    } catch (e) {
      // Handle error
    }
  }
  
  // Method to delete a request
  Future<void> deleteconfrimed(String userID) async {
    try {
    
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('UserRequests')
          .doc(currentUserId)
          .collection('AcceptedRequests')
          .doc(userID)
          .delete();
      
      // Remove the deleted request from the userDataList
      userDataList2.removeWhere((userData2) => userData2['RequesterID'] == userID);
         fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
    } catch (e) {
      // Handle error
    }
  }

  // Method to delete a request
  Future<void> deletewaiting(String userID) async {
    try {
 
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('UserRequests')
          .doc(currentUserId)
          .collection('WaitingRequests')
          .doc(userID)
          .delete();
      
      // Remove the deleted request from the userDataList
      userDataList4.removeWhere((userData4) => userData4['RequesterID'] == userID);
         fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
    } catch (e) {
      // Handle error
    }
  }
  // Method to delete a request
  Future<void> deleteRequestconfrimed(String userID) async {
    try {
    
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('SenderRequests')
          .doc(currentUserId)
          .collection('AcceptedRequests')
          .doc(userID)
          .delete();
      
      // Remove the deleted request from the userDataList
      userDataList4.removeWhere((userData4) => userData4['RequesterID'] == userID);
         fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
    } catch (e) {
      // Handle error
    }
  }


  

  
Future<void> handleRequestButtonTap(BuildContext context, {
  required String userID,
  required Map<String, dynamic> userData,
}) async {
  final confirmed = await _showConfirmationDialog(context);
  
  if (confirmed) {
    try {
      await _sendRequest(userID, userData);
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

Future<void> _sendRequest(String userID, Map<String, dynamic> userData) async {
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
  const status = 'Waiting';
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final firestore = FirebaseFirestore.instance;
///////////////////////////////////////
  await firestore
    .collection('UserRequests')
    .doc(currentUserId)
    .collection('AcceptedRequests')
    .doc(userID)
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
      'Status': status,
    }
    
    );
   fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
        final uid = FirebaseAuth.instance.currentUser!.uid;
    // Get a reference to the collection
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    final String? bloodGroup1 = userSnapshot.data()?['BloodGroup'];
    final String? city1 = userSnapshot.data()?['City'];
    final String? street1 = userSnapshot.data()?['Street'];
    final String? gender1 = userSnapshot.data()?['Gender'];
    final String? phoneNumber1 = userSnapshot.data()?['PhoneNumber'];
    final int age1 = userSnapshot.data()?['Age'];
    final String? email1 = userSnapshot.data()?['Email'];
    final String? profilePicture1 = userSnapshot.data()?['ProfilePicture'];
    final String? userName1 = userSnapshot.data()?['UserName'];
    final String? firstName1 = userSnapshot.data()?['FirstName'];
    final String? lastName1 = userSnapshot.data()?['LastName'];
    final String? eligible = userSnapshot.data()?['Eligible'];
    
  await firestore
    .collection('SenderRequests')
    .doc(userID)
    .collection('AcceptedRequests')
    .doc(currentUserId)
    .set({
      'FirstName': firstName1,
      'LastName': lastName1,
      'Street': street1,
      'Gender': gender1,
      'City': city1,
      'PhoneNumber': phoneNumber1,
      'Age': age1,
      'BloodGroup': bloodGroup1,
      'Email': email1,
      'ProfilePicture': profilePicture1,
      'UserName': userName1,
      'RequesterID': currentUserId,
      'RequesterName': FirebaseAuth.instance.currentUser!.displayName,
      'Status': status,
    });
       fetchData();
    fetchDataAccepted();
    fetchDataConfrimed();
    fetchDataWaiting();
    fetchDataRequest();
}


Future<bool> _showConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Request'),
        content: const Text('Are you sure you want to send a request to this donor?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true if confirmed
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false if canceled
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  ) ?? false; // Default to false if dialog is dismissed
}


}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartController extends GetxController {
  // Define a list to store the fetched data
  RxList<Map<String, dynamic>> ordered = <Map<String, dynamic>>[].obs;

  // Method to fetch data from Firebase subcollection
  Future<void> fetchDataFromSubcollection() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the user ID
        String userId = user.uid;

        // Get the reference to the user's orders collection
        CollectionReference userOrdersCollection = FirebaseFirestore.instance
            .collection('Orders')
            .doc(userId)
            .collection('User_Orders');

        // Get all the documents in the user's orders collection
        QuerySnapshot querySnapshot = await userOrdersCollection.get();

        // Clear the list before adding new data
        ordered.clear();

        // Loop through each document snapshot in the query snapshot
        for (final docSnapshot in querySnapshot.docs) {
          // Get a reference to the document
          DocumentReference docRef = docSnapshot.reference;

          // Get the document snapshot by referencing the document
          DocumentSnapshot document = await docRef.get();

          // Access the desired fields from the document
          final image = document.get('image');
          final productName = document.get('productName');
          final productPrice = document.get('productPrice');
          final productQuantity = document.get('productQuantity');
          final productCategory = document.get('productCategory');
          final sellerName = document.get('sellerName');
          final productDescription = document.get('productDescription');
          final discount = document.get('discount');
          final selectedQuantity = document.get('selectedQuantity');
          final totalAmount = document.get('totalAmount');
          final orderDate = document.get('orderDate');
          final productId = document.get('productId');

          // Add the fields to a map
          final dataMap = {
            'image': image,
            'productName': productName,
            'productPrice': productPrice,
            'productQuantity': productQuantity,
            'productCategory': productCategory,
            'sellerName': sellerName,
            'productDescription': productDescription,
            'discount': discount,
            'selectedQuantity': selectedQuantity,
            'totalAmount': totalAmount,
            'orderDate': orderDate,
            'productId': productId,

            // Add other fields as needed
          };

          // Add the map to the list
          ordered.add(dataMap);
        }
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching data: $e');
      // You can display a message to the user or log the error for debugging
    }
  }
}

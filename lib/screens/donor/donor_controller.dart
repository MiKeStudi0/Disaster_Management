import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorController extends GetxController {
  static DonorController get to => Get.find();
  
  // Define an observable list to hold the fetched data
  var userDataList = <Map<String, dynamic>>[].obs;
    RxList<Map<String, dynamic>> sortedDataList = <Map<String, dynamic>>[].obs;

  
  // Observable boolean to track loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Call a function to fetch data when the controller is initialized
    fetchData();
  }

  void fetchData() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('Users').get();

      // Extract the desired field values from each document
      var dataList = querySnapshot.docs.map((doc) {
                          print('${doc.id}-------------');

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
            'Eligible': doc['Eligible'],
            
          // Add more fields as needed
            };
      }).toList();
      
      // Update the value of the observable list
      userDataList.value = dataList;
    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }
}

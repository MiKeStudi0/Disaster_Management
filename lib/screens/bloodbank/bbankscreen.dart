import 'package:disaster_management/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bbankscreen extends StatelessWidget {
  const Bbankscreen({super.key});
  Future<void> addbbank(String name, String loc, String ph) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.collection('blood_banks').add({
        'name': name,
        'location': loc,
        'phone': ph,
      });
    } catch (e) {
      print('Error ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Banks'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('blood_banks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error: snapshot illa'),
            );
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              return Card(
                color: dark ? Colors.white : Colors.black,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.bloodtype, size: 36),
                  title: Text(
                    data['name'] ?? '',
                    style: TextStyle(
                        fontSize: 18,
                        color: !dark ? Colors.white : Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['location'] ?? '',
                        style: TextStyle(
                            fontSize: 15,
                            color: !dark ? Colors.white : Colors.black),
                      ),
                      Text(
                        data['phone'] ?? '',
                        style: TextStyle(
                            fontSize: 15,
                            color: !dark ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}

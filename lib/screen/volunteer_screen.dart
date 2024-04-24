import 'dart:ui';

import 'package:disaster_management/volunteer/volunteer_list.dart';
import 'package:disaster_management/volunteer/volunteer_reg.dart';
import 'package:flutter/material.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Volunteer',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 32, 3, 176),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 32, 3, 176),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              Positioned(
                top: 1.2 * kToolbarHeight + 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VolunteerReg()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height:
                            MediaQuery.of(context).size.width / 3, // Square box
                        decoration: BoxDecoration(
                          color:
                              Colors.blue.withOpacity(0.2), // Transparent blue
                          border: Border.all(
                              color: const Color.fromARGB(26, 90, 89, 89),
                              width: 2), // White border
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,
                                color: Colors.white), // Example icon
                            SizedBox(
                                height: 8), // Spacing between icon and text
                            Text('Registration',
                                style: TextStyle(
                                    color: Colors.white)), // Example text
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCodeInputDialog(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color:
                              Colors.red.withOpacity(0.2), // Transparent blue
                          border: Border.all(
                              color: const Color.fromARGB(26, 90, 89, 89),
                              width: 2), // White border
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.note, color: Colors.white),
                            SizedBox(height: 8),
                            Text('Volunteer List',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showCodeInputDialog(BuildContext context) async {
  String enteredCode = '';
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Code'),
        content: TextField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Enter code'),
          onChanged: (value) {
            enteredCode = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              codeconfirm(enteredCode, context);
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );

  // Check if the entered code is correct
}

void codeconfirm(String enteredCode, context) {
  if (enteredCode == '1234') {
    // Navigate to VolunteerList page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerList()),
    );
  } else {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Incorrect code')),
    );
  }
}

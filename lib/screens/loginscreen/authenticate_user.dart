import 'package:disaster_management/screens/homescren/homepage.dart';
import 'package:disaster_management/screens/loginscreen/intro_one_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Homescreen();
          } else {
            return const IntroOneScreen();
          }
        },
      ),
    );
  }
}

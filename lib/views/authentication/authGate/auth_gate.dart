import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskey_app/views/Home/home_view.dart';
import 'package:taskey_app/views/authentication/signUp/signup_view.dart';
import 'package:taskey_app/views/main/main_screen.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const SignupView();
          }
          return MainScreen();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

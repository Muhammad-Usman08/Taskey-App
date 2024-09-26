import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/firebase_options.dart';
import 'package:taskey_app/views/authentication/signUp/signup_view.dart';
import 'package:taskey_app/views/main/main_screen.dart';
import 'package:taskey_app/views/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/views/splash/splash_view.dart';

void main() {}

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

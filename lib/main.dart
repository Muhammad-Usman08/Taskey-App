import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskey_app/Model/firestore_controller.dart';
import 'package:taskey_app/firebase_options.dart';
import 'package:taskey_app/views/settings/setting_view_model.dart';

import 'package:taskey_app/views/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance();
  Get.put(SettingViewModel());
  Get.put(FirestoreController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingViewModel settingViewModel = Get.find();
    return Obx(() {
      return GetMaterialApp(
        home: SplashView(),
        theme: settingViewModel.themeData,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

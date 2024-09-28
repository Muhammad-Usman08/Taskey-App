import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskey_app/views/authentication/authGate/auth_gate.dart';
class OnboardingPage {
  final String title;
  final String subtitle;
  final String mainImage; // Main person image
  final List<String> floatingImages; // Floating avatars

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.mainImage,
    required this.floatingImages,
  });
}

List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    title: "Task Management",
    subtitle: "Let's create a\nspace for your\nworkflows.",
    mainImage: "assets/images/person.png", 
    floatingImages: [
      "assets/images/ellipses1.png", 
      "assets/images/elipses2.png",
      "assets/images/elipse3.png", 
    ],
  ),
  OnboardingPage(
    title: "Task Management",
    subtitle: "Work more\nStructured and\nOrganized 👌.",
    mainImage: "assets/images/person.png", 
    floatingImages: [
      "assets/images/Rectangle.png",
      "assets/images/Rectangle.png",
    ],
  ),
  OnboardingPage(
    title: "Task Management",
    subtitle: "Manage your\nTasks quickly for\nResults ✌",
    mainImage: "assets/images/person2.png",
    floatingImages: [
      "assets/images/Rectangle.png",
    ],
  ),
];
Text getFormattedSubtitle(
    String subtitle, String highlightWord, Color highlightColor) {
  List<TextSpan> spans = [];
  List<String> parts = subtitle.split(highlightWord);

  for (int i = 0; i < parts.length; i++) {
    spans.add(
        TextSpan(text: parts[i], style: const TextStyle(color: Colors.black)));
    if (i < parts.length - 1) {
      spans.add(TextSpan(
          text: highlightWord,
          style: TextStyle(
            color: highlightColor,
            fontWeight: FontWeight.bold, 
          )));
    }
  }

  return Text.rich(
    TextSpan(children: spans),
    textAlign: TextAlign.left,
    style: const TextStyle(fontSize: 25, height: 1.5),
  );
}
class OnBoardingController extends GetxController {
  var isOnboardingCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isOnboardingCompleted.value = prefs.getBool('onboarding_completed') ?? false;

    if (isOnboardingCompleted.value) {
      // Navigate to AuthGate if onboarding is completed
      Get.off(AuthGate());
    }
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    isOnboardingCompleted.value = true;

    // Navigate to AuthGate after completing onboarding
    Get.off(AuthGate());
  }
}
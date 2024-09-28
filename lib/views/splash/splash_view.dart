import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/authentication/signUp/signup_view.dart';
import 'package:taskey_app/views/onBoarding/on_boarding_view.dart';
import 'package:taskey_app/views/settings/setting_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingViewModel settingsController = Get.find();
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    Color getColor(Color lightColor, Color darkColor) {
      return settingsController.isDarkModeEnabled == true
          ? darkColor
          : lightColor;
    }

    return Scaffold(
      backgroundColor: const Color(themeColor),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            SizedBox(
              height: height * 0.5,
              width: width,
              child: Image.asset(
                'assets/images/image.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                child: Container(
                  height: height * 0.52,
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                  decoration: BoxDecoration(
                    color: getColor(Colors.white, Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Taskey',
                        weight: FontWeight.w900,
                        fontSize: 40,
                        color: Color(themeColor),
                      ),
                      const SizedBox(height: 18),
                      CustomText(
                        text: 'Building Better \nWorkplaces ',
                        weight: FontWeight.w800,
                        textAlign: TextAlign.center,
                        color: getColor(
                          Colors.black,
                          Colors.white,
                        ),
                        fontSize: 30,
                      ),
                      const SizedBox(height: 18),
                      const CustomText(
                        text:
                            'Create a unique emotional story that \ndescribes better than words',
                        textAlign: TextAlign.center,
                        weight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 30),
                      CommonButton(
                        title: 'Get Started',
                        vertcalPaddingM: 17,
                        onPressed: () {
                          Get.off(() => OnBoardingView());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

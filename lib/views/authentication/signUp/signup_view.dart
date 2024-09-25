import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/Home/home_view.dart';
import 'package:taskey_app/views/authentication/login/login_view.dart';
import 'package:taskey_app/views/main/main_screen.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: CustomText(
            text: 'Sign Up',
            weight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Create Account',
              weight: FontWeight.w600,
              fontSize: 25,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: 'Please Enter your Informatioin and \ncreate your account',
              color: Colors.grey,
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    // backgroundImage: AssetImage(''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: const Color(0xffececec),
                      child: SvgPicture.asset('assets/svg/camera.svg'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              hintText: 'Enter you Name',
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
              hintText: 'Enter you email',
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
              hintText: 'Enter you password',
            ),
            const SizedBox(
              height: 35,
            ),
            CommonButton(
              title: 'Sign Up',
              vertcalPaddingM: 15,
              onPressed: () {
                Get.to(() => MainScreen());
              },
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Have an Account?',
                  color: Colors.grey,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginView());
                  },
                  child: const CustomText(
                    text: 'Sign In',
                    color: Color(themeColor),
                    weight: FontWeight.w800,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

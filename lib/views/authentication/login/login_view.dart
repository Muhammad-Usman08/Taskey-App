import 'package:flutter/material.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          text: 'Sign In',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Welcome Back',
              weight: FontWeight.w600,
              fontSize: 25,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: 'Please Enter your email address \nand password for Login',
              color: Colors.grey,
            ),
            const SizedBox(
              height: 40,
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
              title: 'Sign In',
              vertcalPaddingM: 15,
            ),
          ],
        ),
      ),
    );
  }
}

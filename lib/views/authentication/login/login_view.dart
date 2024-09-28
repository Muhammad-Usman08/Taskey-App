import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/authentication/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel controller = Get.put(LoginViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Sign In',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Welcome Back',
                weight: FontWeight.w600,
                fontSize: 25,
              ),
              const SizedBox(height: 10),
              const CustomText(
                text:
                    'Please Enter your email address \nand password for Login',
                color: Colors.grey,
              ),
              const SizedBox(height: 40),
              // Email TextField
              CustomTextField(
                hintText: 'Enter your email',
                controller: controller.emailController,
              ),
              const SizedBox(height: 25),
              // Password TextField
              CustomTextField(
                hintText: 'Enter your password',
                controller: controller.passwordController,
                obscureText: true, // Set to true for password field
              ),
              const SizedBox(height: 35),
              // Sign In Button
              Obx(() {
                return CommonButton(
                  title: controller.loading.value ? 'Signing In...' : 'Sign In',
                  isLoading: controller.loading.value,
                  vertcalPaddingM: 15,
                  onPressed: controller.loading.value
                      ? null // Disable button while loading
                      : () {
                          controller.login();
                        },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

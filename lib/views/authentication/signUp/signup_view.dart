import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/authentication/login/login_view.dart';
import 'package:taskey_app/views/authentication/signUp/signup_view_model.dart';
import 'package:taskey_app/views/main/main_screen.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupViewModel controller = Get.put(SignupViewModel());
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
        child: SingleChildScrollView(
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
                text:
                    'Please Enter your Informatioin and \ncreate your account',
                color: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: controller.imageFile.value.isNotEmpty
                              ? FileImage(File(controller.imageFile.value))
                              : null,
                          child: controller.imageFile.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey,
                                )
                              : null,
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
                  );
                }),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                hintText: 'Enter you Name',
                controller: controller.usernameController,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                hintText: 'Enter you email',
                controller: controller.emailController,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                hintText: 'Enter you password',
                controller: controller.passwordController,
              ),
              const SizedBox(
                height: 35,
              ),
              Obx(() {
                return CommonButton(
                  title: controller.loading.value ? 'Signing Up...' : 'Sign Up',
                  isLoading: controller.loading.value,
                  onPressed: controller.loading.value
                      ? null // Disable button while loading
                      : () {
                          controller.signup();
                        },
                  vertcalPaddingM: 15,
                );
              }),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/authentication/controller/login_screen_controller.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/routes/app_routes.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/common/widgets/auhe_custom_textfiled.dart'
    show AuthCustomTextField;
import '../../../core/common/widgets/custom_contain_button.dart'
    show CustomContinueButton;

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  LoginScreenController loginController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Log In',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  onChanged: (value) {},
                  controller: loginController.emailController,
                  text: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Incorrect email or password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Obx(() {
                  return AuthCustomTextField(
                    onChanged: (value) {
                      loginController.validateFrom();
                    },
                    text: 'Enter your password',
                    controller: loginController.passwordControler,
                    obscureText: loginController.isPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect email or password';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: 32),
                CustomContinueButton(
                  onTap: () {
                  Get.offAll(BottomNavbarView());
                  },
                  textColor:
                      loginController.emailController.text.isEmpty &&
                              loginController.passwordControler.text.isEmpty
                          ? Color(0xFF37B874)
                          : Colors.white,
                  title: "Log In",
                  backgroundColor:
                      loginController.emailController.text.isEmpty &&
                              loginController.passwordControler.text.isEmpty
                          ? Color(0xFFEBF8F1)
                          : Color(0xFF37B874),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.forgotPasswordScreen);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: getTextStyle(
                        color: Color(0xFF3A4C67),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                // CustomDivider(),
                SizedBox(height: 32),
                if (Platform.isAndroid || Platform.isIOS) ...[
                  // GestureDetector(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     decoration: BoxDecoration(
                  //       color: Color(0XFF5384EE),
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(IconPath.google, width: 24, height: 24),
                  //         SizedBox(width: 12),
                  //         Text(
                  //           "Continue with Google",
                  //           style: globalTextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
                SizedBox(height: 16),
                if (Platform.isIOS) ...[
                  // GestureDetector(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     decoration: BoxDecoration(
                  //       color: Colors.black,
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(IconPath.apple, width: 24, height: 24),
                  //         SizedBox(width: 12),
                  //         Text(
                  //           "Continue with Apple",
                  //           style: globalTextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8), 
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.signupScreen);
                      },
                      child: Text(
                        "Sign Up",
                        style: getTextStyle(
                          color: Color(0xFF37B874),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

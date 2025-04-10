import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/routes/app_routes.dart';
import '../../../core/common/styles/global_text_style.dart' show getTextStyle;
import '../../../core/common/widgets/auhe_custom_textfiled.dart'
    show AuthCustomTextField;
import '../controller/forget_password_controller.dart'
    show ForgetPasswordController;

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);
  final ForgetPasswordController forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff333333),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Center(
              child: Text(
                "Please Enter your email address or phone",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5F5F5F),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "number for confirmation code.",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5F5F5F),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              height: 44,
              width: 190,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      focusedButtonIndex.value = 0;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: focusedButtonIndex,
                      builder: (context, value, child) {
                        return Container(
                          height: 44,
                          width: 93,
                          decoration: BoxDecoration(
                            color:
                                value == 0
                                    ? Color(0xFF3A4C67)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Email",
                              style: getTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                    value == 0
                                        ? Colors.white
                                        : Color(0xff082B09),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      focusedButtonIndex.value = 1;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: focusedButtonIndex,
                      builder: (context, value, child) {
                        return Container(
                          height: 44,
                          width: 93,
                          decoration: BoxDecoration(
                            color:
                                value == 1
                                    ? Color(0xFF3A4C67)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Phone",
                              style: getTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                    value == 1
                                        ? Colors.white
                                        : Color(0xff082B09),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 31),
            ValueListenableBuilder<int>(
              valueListenable: focusedButtonIndex,
              builder: (context, value, child) {
                return Column(
                  children: [
                    if (value == 0)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            AuthCustomTextField(
                              controller:
                                  forgetPasswordController.emailController,
                              text: "Enter your Email",
                            ),
                          ],
                        ),
                      ),
                    if (value == 1)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone",
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            AuthCustomTextField(
                              controller:
                                  forgetPasswordController.phoneController,
                              text: "Enter your phone number",
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 63),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xFF37B874),
                    minimumSize: Size(double.infinity, 48),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoute.otpSentScreen2);
                  },
                  child: Text(
                    "Send",
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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

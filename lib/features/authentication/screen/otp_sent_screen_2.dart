import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/routes/app_routes.dart';

import '../../../core/common/styles/global_text_style.dart' show getTextStyle;
import '../controller/forget_password_controller.dart'
    show ForgetPasswordController;
import '../widget/custom_pin_feild.dart';

// ignore: use_key_in_widget_constructors
class OtpSentScreen2 extends StatelessWidget {
  // Initialize the controller here
  final ForgetPasswordController vForgetPasswordController = Get.put(
    ForgetPasswordController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter the\n confirmation  code',
                style: getTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              CustomPinField(
                controller: vForgetPasswordController.pinController2,
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Verification code has been sent to your email address ',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '0724****',
                      style: getTextStyle(
                        color: Color(0xFF37B874),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Code to resend OTP
                },
                child: Text(
                  "Resend Code",
                  style: getTextStyle(
                    color: Color(0xFF3A4C67),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  title: 'Continue',
                  textcolor:
                      vForgetPasswordController.isFormVaid.value
                          ? Colors.white
                          : Color(0xFF37B874),
                  onPress:
                      vForgetPasswordController.isFormVaid.value
                          ? () {
                            Get.toNamed(AppRoute.changePassword);
                          }
                          : null,
                  backgroundColor:
                      vForgetPasswordController.isFormVaid.value
                          ? Color(0xFF37B874)
                          : Color(0xFFEBF8F1),
                  borderColor:
                      vForgetPasswordController.isFormVaid.value
                          ? Color(0xFF37B874)
                          : Color(0xFFEBF8F1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

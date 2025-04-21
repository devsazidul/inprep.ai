import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/features/authentication/controller/forget_password_controller.dart';
import 'package:inprep_ai/routes/app_routes.dart' show AppRoute; 

class OtpSentScreen extends StatelessWidget {
  OtpSentScreen({super.key});

  final ForgetPasswordController controller = Get.find<ForgetPasswordController>(); 

  String getMaskedEmail(String email) {
    if (email.length <= 14) {
      return '*' * email.length;
    }
    int maskLength = email.length - 14;
    return '*' * maskLength + email.substring(maskLength);
  }

  String getMaskedPhone(String phone) {
    if (phone.length <= 4) {
      return phone;
    }
    return phone.substring(0, 4) + '*' * (phone.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'Enter the\n confirmation  code',
              style: getTextStyle(
                color: const Color(0xFF333333),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color(0xFFE5E6EB),
              focusedBorderColor: const Color(0xFFE5E6EB),
              cursorColor: Colors.black,
              showFieldAsBox: true,
              borderRadius: BorderRadius.circular(8),
              contentPadding: const EdgeInsets.all(8),
              onSubmit: (String verificationCode) {
                if (kDebugMode) {
                  print("Entered OTP: $verificationCode");
                }
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              final isEmail = controller.toggleValue.value == 0;
              final maskedText = isEmail
                  ? getMaskedEmail(controller.emailController.text)
                  : getMaskedPhone(controller.phoneController.text);
              final prefixText = isEmail
                  ? 'Verification code has been sent to your email address '
                  : 'Verification code has been sent to your phone number ';
              return Text.rich(
                TextSpan(
                  text: prefixText,
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: maskedText,
                      style: getTextStyle(
                        color: const Color(0xFF37B874),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              );
            }),
            SizedBox(
              height: 20,
            ), 
            TextButton(
              onPressed: (){}, 
              child: Text('Resend Code', 
               style: getTextStyle(
                color: Color(0xFF3A4C67), 
                fontSize: 14, 
                fontWeight: FontWeight.w500,
               ),
              )
              ), 
            SizedBox(
              height: 40,
            ), 
            CustomButton(
              backgroundColor: Color(0xFF37B874),
              textcolor: Colors.white,
              borderColor: Color(0xFF37B874),
              title: "Continue", 
              onPress: (){
                Get.toNamed(AppRoute.changePassword);
              })
          ],
        ),
      ),
    );
  }
}

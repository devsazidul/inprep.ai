import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:inprep_ai/core/common/widgets/auhe_custom_textfiled.dart';
import 'package:inprep_ai/features/authentication/controller/forget_password_controller.dart'
    show ForgetPasswordController;
import 'package:inprep_ai/features/authentication/screen/otp_sent_screen.dart';
import 'package:inprep_ai/features/authentication/widget/custom_send_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 65),
        child: Center(
          child: Column(
            children: [
              Text(
                "Forget Password",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 60),
              Text(
                "Please Enter your email address or phone\nnumber for confirmation code.",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5F5F5F),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    ()=> GestureDetector(
                      onTap: () {
                        if(controller.toggleValue.value != 0){
                          controller.toggle();
                        }         
                        
                      },
                      child: Container(
                        width: 84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              controller.toggleValue.value == 0
                                  ? Color(0xFF3A4C67)
                                  : Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              "Email",
                              style: getTextStyle(
                                color: controller.toggleValue.value == 0
                                    ? Colors.white
                                    : Color(0xFF3A4C67),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    ()=> GestureDetector(
                      onTap: () {
                        if(controller.toggleValue.value != 1){
                          controller.toggle();
                        }
                
                        
                      },
                      child: Container(
                        width: 84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              controller.toggleValue.value == 1
                                  ? Color(0xFF3A4C67)
                                  : Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              "Phone",
                              style: getTextStyle(
                                color: controller.toggleValue.value == 1
                                    ? Colors.white
                                    : Color(0xFF3A4C67),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ), 
               Align(
                alignment: Alignment.bottomLeft,
                 child: Obx(
                   ()=> Text(
                    controller.toggleValue.value == 0
                        ? "Email"
                        : "Phone",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                   ),
                 ),
               ), 
               SizedBox(
                height: 10,
               ), 
               Obx(
                 ()=>  AuthCustomTextField(
                  controller: controller.toggleValue.value == 0
                      ? controller.emailController
                      : controller.phoneController, 
                  text: controller.toggleValue.value == 0
                      ? "Enter your Email"
                      : "Enter your phone number",
                               ),
               ), 
               SizedBox(
                height: 60,
               ), 
               CustomSendButton(
                onPressed: (){
                  Get.to(() => OTPScreen());
                },
                text: "Send",)
            ],
          ),
        ),
      ),
    );
  }
}

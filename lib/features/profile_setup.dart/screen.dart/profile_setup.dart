import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_slider.dart';
import 'package:inprep_ai/features/splash_screen/widgets/custom_button.dart';

// ignore: must_be_immutable
class ProfileSetup extends StatelessWidget {
  ProfileSetup({super.key});
  ProfileSetupcontroller profileSetupcontroller = Get.put(
    ProfileSetupcontroller(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hellow Russell! \nWelcome",
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff212121),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImagePath.hellow1,
                    height: 233.755,
                    width: 229.059,
                  ),
                ),
                SizedBox(height: 36),
                Text(
                  "Upload Your Resume",
                  style: getTextStyle(
                    color: Color(0xff37BB74),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBF8F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(IconPath.backup, height: 32, width: 32),
                            SizedBox(height: 8),
                            Text(
                              "Select File",
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff212121),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Supported Formats: PDF, DOC, DOCX",
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 48),
                CustomButton(
                  text: "Continue",
                  width: double.infinity,
                  height: 48,
                  textColor: Colors.white,
                  buttonColor: Color(0xff37BB74),
                  onTap: () {},
                ),
                SizedBox(height: 16),
                CustomButton1(
                  title: "Enter Manually",
                  textcolor: Color(0xff37BB74),
                  borderColor: Color(0xff37BB74),
                  backgroundColor: Colors.white,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileSlider()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

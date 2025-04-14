import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/profile_screen/widgets/custom_profile_textfield.dart';

import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset(IconPath.profileicon),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Jakob Vaccaro",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff212121),
                ),
              ),
              SizedBox(height: 4),
              Text(
                "jakob@123",
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff212121),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Edit",
                      style: getTextStyle(
                        color: Color(0xff37B874),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.edit, size: 15, color: Color(0xff37B874)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Personal Information",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),

                child: Column(
                  
                  children: [
                    CustomProfileTextField(
                      label: "Full Name",
                      controller: profileController.fullNameController,
                      hintText: "Jakob Vaccaro",
                      enabled: profileController.isEditing.value,
                    ),
                    CustomProfileTextField(
                      label: "Email",
                      controller: profileController.fullNameController,
                      hintText: "Jakob@gmail.com",
                      enabled: profileController.isEditing.value,
                    ),
                    CustomProfileTextField(
                      label: "Experience Level",
                      controller: profileController.fullNameController,
                      hintText: "Software Engineer",
                      enabled: profileController.isEditing.value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

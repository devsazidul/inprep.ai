import 'dart:io';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children:[ CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius:
                              58, // Slightly smaller radius for the inner CircleAvatar
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius:
                                80, // Even smaller for the innermost CircleAvatar
                            backgroundImage:
                                profileController.selectedImagePath.value.isEmpty
                                    ? (profileController.logoUrl.value.isNotEmpty
                                        ? NetworkImage(
                                          profileController.logoUrl.value,
                                        )
                                        : AssetImage(IconPath.profileicon)
                                            as ImageProvider)
                                    : FileImage(
                                      File(
                                        profileController.selectedImagePath.value,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(15, 95),
                        child: GestureDetector(
                          onTap: (){
                            profileController.showImagePicker(context);
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 12,
                              color: Color(0xff37BB74),
                            )
                          ),
                        )
                      )
                      ]
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
                  onTap: () {
                    
                    profileController.toggleEdit();
                  },
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
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
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
                          enabled: profileController.isEditing.isFalse,
                        ),
                        CustomProfileTextField(
                          label: "Experience Level",
                          controller: profileController.fullNameController,
                          hintText: "Intermideate",
                          enabled: profileController.isEditing.value,
                        ),
                        CustomProfileTextField(
                          label: "Preferred interview Focus",
                          controller: profileController.preferredController,
                          hintText: "Technical",
                          enabled: profileController.isEditing.value,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Performance",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        CustomProfileTextField(
                          label: "Interview Taken",
                          controller: profileController.interviewController,
                          hintText: "18",
                          enabled: profileController.isEditing.isFalse,
                        ),
                        CustomProfileTextField(
                          label: "Confidence",
                          controller: profileController.confidenceController,
                          hintText: "80%",
                          enabled: profileController.isEditing.isFalse,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

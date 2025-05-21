// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';
// import 'package:inprep_ai/core/utils/constants/colors.dart';
// import 'package:inprep_ai/core/utils/constants/icon_path.dart';
// import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
// import 'package:inprep_ai/features/profile_screen/screen/chooseplan_screen.dart';
// import 'package:inprep_ai/features/profile_screen/widgets/custom_profile_textfield.dart';
// import '../controller/profile_controller.dart';

// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});

//   final ProfileController profileController = Get.put(ProfileController());
//   final HomeScreenController homeScreenController = Get.find();

//   Widget _buildProfileImage() {
//     if (profileController.selectedImagePath.value.isNotEmpty) {
//       return CircleAvatar(
//         radius: 80,
//         backgroundImage: FileImage(
//           File(profileController.selectedImagePath.value),
//         ),
//       );
//     } else if (profileController.logoUrl.value.isNotEmpty) {
//       return CircleAvatar(
//         radius: 80,
//         backgroundImage: NetworkImage(profileController.logoUrl.value),
//       );
//     }
//     return CircleAvatar(
//       radius: 80,
//       backgroundImage: const AssetImage(IconPath.profileicon),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       body: SafeArea(
//         child: Obx(() {
//           if (profileController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Stack(
//                         children: [
//                           CircleAvatar(
//                             radius: 60,
//                             backgroundColor: Colors.white,
//                             child: CircleAvatar(
//                               radius: 58,
//                               backgroundColor: Colors.white,
//                               child: _buildProfileImage(),
//                             ),
//                           ),
//                           Transform.translate(
//                             offset: const Offset(15, 95),
//                             child: GestureDetector(
//                               onTap: () {
//                                 profileController.showImagePicker(context);
//                               },
//                               child: Container(
//                                 height: 24,
//                                 width: 24,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: const Icon(
//                                   Icons.edit,
//                                   size: 12,
//                                   color: Color(0xff37BB74),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     profileController.fullNameController.text.isNotEmpty
//                         ? profileController.fullNameController.text
//                         : homeScreenController.userInfo.value?.data?.name ??
//                             "Jakob Vaccaro",
//                     style: getTextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff212121),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     homeScreenController.userInfo.value?.data?.email ??
//                         "jakob@123",
//                     style: getTextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff212121),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   GestureDetector(
//                     onTap: profileController.toggleEdit,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           profileController.isEditing.value ? "Save" : "Edit",
//                           style: getTextStyle(
//                             color: Color(0xff37BB74),
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Icon(
//                           profileController.isEditing.value ? Icons.save : Icons.edit,
//                           size: 15,
//                           color: Color(0xff37B874),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Personal Information",
//                         style: getTextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff212121),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 12,
//                         right: 12,
//                         top: 5,
//                         bottom: 5,
//                       ),
//                       child: Column(
//                         children: [
//                           CustomProfileTextField(
//                             label: "Full Name",
//                             controller: profileController.fullNameController,
//                             hintText: "Enter your full name",
//                             enabled: profileController.isEditing.value,
//                           ),
//                           CustomProfileTextField(
//                             label: "Email",
//                             controller: profileController.emailController,
//                             hintText: "Enter your email",
//                             enabled: false,
//                           ),
//                           CustomProfileTextField(
//                             label: "Experience Level",
//                             controller: profileController.experiecnceController,
//                             hintText: "Enter your experience level",
//                             enabled: profileController.isEditing.value,
//                           ),
//                           CustomProfileTextField(
//                             label: "Preferred Interview Focus",
//                             controller: profileController.preferredController,
//                             hintText: "Enter your preferred focus",
//                             enabled: profileController.isEditing.value,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Performance",
//                         style: getTextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff212121),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 12,
//                         right: 12,
//                         top: 5,
//                         bottom: 5,
//                       ),
//                       child: Column(
//                         children: [
//                           CustomProfileTextField(
//                             label: "Interview Taken",
//                             controller: profileController.interviewController,
//                             hintText: "18",
//                             enabled: false,
//                           ),
//                           CustomProfileTextField(
//                             label: "Confidence",
//                             controller: profileController.confidenceController,
//                             hintText: "80%",
//                             enabled: false,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Subscription",
//                         style: getTextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff212121),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 12,
//                         right: 12,
//                         top: 5,
//                         bottom: 5,
//                       ),
//                       child: Column(
//                         children: [
//                           CustomProfileTextField(
//                             label: "Current Plan",
//                             controller: profileController.currentplanController,
//                             hintText: "Free Plan",
//                             enabled: false,
//                           ),
//                           const SizedBox(height: 10),
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: GestureDetector(
//                               onTap: () {
//                                 Get.to(() => ChooseplanScreen());
//                               },
//                               child: Text(
//                                 "Upgrade",
//                                 style: getTextStyle(
//                                   color: Color(0xff37BB74),
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.width * 0.28),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
import 'package:inprep_ai/features/profile_screen/screen/chooseplan_screen.dart';
import 'package:inprep_ai/features/profile_screen/widgets/custom_profile_textfield.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final HomeScreenController homeScreenController = Get.find();

  Widget _buildProfileImage() {
    if (profileController.selectedImagePath.value.isNotEmpty) {
      return CircleAvatar(
        radius: 80,
        backgroundImage: FileImage(
          File(profileController.selectedImagePath.value),
        ),
      );
    } else if (profileController.logoUrl.value.isNotEmpty) {
      return CircleAvatar(
        radius: 80,
        backgroundImage: NetworkImage(profileController.logoUrl.value),
      );
    }
    return CircleAvatar(
      radius: 80,
      backgroundImage: const AssetImage(IconPath.profileicon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundColor: Colors.white,
                              child: _buildProfileImage(),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(15, 95),
                            child: GestureDetector(
                              onTap: () {
                                profileController.showImagePicker(context);
                              },
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 12,
                                  color: Color(0xff37BB74),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profileController.fullNameController.text.isNotEmpty
                        ? profileController.fullNameController.text
                        : 'No Name Available',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profileController.emailController.text.isNotEmpty
                        ? profileController.emailController.text
                        : 'No Email Available',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: profileController.toggleEdit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          profileController.isEditing.value ? "Save" : "Edit",
                          style: getTextStyle(
                            color: Color(0xff37BB74),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          profileController.isEditing.value ? Icons.save : Icons.edit,
                          size: 15,
                          color: Color(0xff37B874),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 10),
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
                            hintText: "Enter your full name",
                            enabled: profileController.isEditing.value,
                          ),
                          CustomProfileTextField(
                            label: "Email",
                            controller: profileController.emailController,
                            hintText: "Enter your email",
                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "Experience Level",
                            controller: profileController.experiecnceController,
                            hintText: "Enter your experience level",
                            enabled: profileController.isEditing.value,
                          ),
                          CustomProfileTextField(
                            label: "Preferred Interview Focus",
                            controller: profileController.preferredController,
                            hintText: "Enter your preferred focus",
                            enabled: profileController.isEditing.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 12),
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
                            hintText: "0",
                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "Confidence",
                            controller: profileController.confidenceController,
                            hintText: "0%",
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff212121),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                            label: "Current Plan",
                            controller: profileController.currentplanController,
                            hintText: "Free Plan",
                            enabled: false,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => ChooseplanScreen());
                              },
                              child: Text(
                                "Upgrade",
                                style: getTextStyle(
                                  color: Color(0xff37BB74),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.28),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
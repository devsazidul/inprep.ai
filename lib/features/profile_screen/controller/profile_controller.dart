// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:inprep_ai/core/urls/endpint.dart';
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
// import 'package:path/path.dart' as path;
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileController extends GetxController {
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController experiecnceController = TextEditingController();
//   final TextEditingController preferredController = TextEditingController();
//   final TextEditingController interviewController = TextEditingController();
//   final TextEditingController confidenceController = TextEditingController();
//   final TextEditingController currentplanController = TextEditingController();

//   final HomeScreenController homeScreenController = Get.find();

//   var isEditing = false.obs;
//   var logoUrl = ''.obs;
//   var selectedImagePath = ''.obs;
//   var hasImageChanged = false.obs;
//   var isLoading = false.obs;

//   String originalFullName = '';
//   String originalExperience = '';
//   String originalPreferred = '';

//   @override
//   void onInit() {
//     super.onInit();
//     initializeData();
//   }

//   @override
//   void onClose() {
//     fullNameController.dispose();
//     emailController.dispose();
//     experiecnceController.dispose();
//     preferredController.dispose();
//     interviewController.dispose();
//     confidenceController.dispose();
//     currentplanController.dispose();
//     super.onClose();
//   }

//   Future<void> initializeData() async {
//     try {
//       isLoading(true);


//       final user = homeScreenController.userInfo.value?.data;
//       if (user != null) {
//         fullNameController.text = user.name ?? '';
//         emailController.text = user.email ?? '';
//         experiecnceController.text = user.experienceLevel ?? '';
//         preferredController.text = user.preferedInterviewFocus ?? '';
//         currentplanController.text = user.currentPlan ?? 'Free Plan';
//         interviewController.text = user.interviewTaken?.toString() ?? '18';
//         confidenceController.text = user.confidence?.toString() ?? '80%';

//         if (user.img != null && user.img!.isNotEmpty) {
//           logoUrl.value = user.img!;
//         }
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load profile data');
//     } finally {
//       isLoading(false);
//     }
//   }

//   void toggleEdit() {
//     if (isEditing.value) {
//       saveChanges();
//     } else {
//       originalFullName = fullNameController.text;
//       originalExperience = experiecnceController.text;
//       originalPreferred = preferredController.text;
//       isEditing.value = true;
//     }
//   }

//   Future<void> saveChanges() async {
//     await updateProfile(
//       name: fullNameController.text,
//       experienceLevel: experiecnceController.text,
//       preferredInterviewFocus: preferredController.text,
//     );
//   }

//   Future<void> updateProfile({
//     required String name,
//     required String experienceLevel,
//     required String preferredInterviewFocus,
//   }) async {
//     try {
//       EasyLoading.show(status: "Updating profile...");
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.reload();
//       final accessToken = prefs.getString('approvalToken');

//       if (accessToken == null || accessToken.isEmpty) {
//         throw Exception('No access token found');
//       }

//       final url = Uri.parse(Urls.updateProfile);
//       final request = http.MultipartRequest('PATCH', url);
//       request.headers['Authorization'] = accessToken;

//       final requestData = {
//         'name': name,
//         'experienceLevel': experienceLevel,
//         'preferredInterviewFocus': preferredInterviewFocus,
//       };

//       request.fields['data'] = jsonEncode(requestData);

//       if (selectedImagePath.value.isNotEmpty) {
//         final file = File(selectedImagePath.value);
//         if (await file.exists()) {
//           final fileName = path.basename(file.path);
//           final multipartFile = await http.MultipartFile.fromPath(
//             'img',
//             file.path,
//             filename: fileName,
//           );
//           request.files.add(multipartFile);
//         }
//       }

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//       final responseData = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (responseData['success'] == true) {
//           await _handleSuccessResponse(
//             responseData,
//             name,
//             experienceLevel,
//             preferredInterviewFocus,
//           );
//           EasyLoading.showSuccess("Profile updated successfully!");
//           isEditing.value = false;
          
//         } else {
//           throw Exception(responseData['message'] ?? "Profile update failed");
//         }
//       } else {
//         throw Exception(_parseError(responseData, response.statusCode));
//       }
//     } catch (e) {
//       EasyLoading.showError(
//         'Update failed: ${e.toString().replaceAll('Exception: ', '')}',
//       );
//       // Revert to original values on failure
//       fullNameController.text = originalFullName;
//       experiecnceController.text = originalExperience;
//       preferredController.text = originalPreferred;
//     }
//   }

//   Future<void> _handleSuccessResponse(
//     Map<String, dynamic> data,
//     String name,
//     String experienceLevel,
//     String preferredInterviewFocus,
//   ) async {
//     if (data['data'] != null && data['data']['img'] != null) {
//       logoUrl.value = data['data']['img'];
//       selectedImagePath.value = '';
//       hasImageChanged.value = false;
//     }

//     fullNameController.text = data['data']['name'] ?? name;
//     experiecnceController.text =
//         data['data']['experienceLevel'] ?? experienceLevel;
//     preferredController.text =
//         data['data']['preferredInterviewFocus'] ?? preferredInterviewFocus;

//     if (data['data']['currentPlan'] != null) {
//       currentplanController.text = data['data']['currentPlan'];
//     }
//   }

//   String _parseError(Map<String, dynamic> data, int statusCode) {
//     if (data['message'] != null) {
//       return data['message'];
//     }

//     switch (statusCode) {
//       case 400:
//         return 'Invalid request data';
//       case 401:
//         return 'Authentication failed';
//       case 403:
//         return 'Permission denied';
//       case 404:
//         return 'Profile not found';
//       case 500:
//         return 'Server error';
//       default:
//         return 'Update failed (status $statusCode)';
//     }
//   }

//   final ImagePicker _imagePicker = ImagePicker();

//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(source: source);
//       if (pickedFile != null) {
//         selectedImagePath.value = pickedFile.path;
//         hasImageChanged.value = true;
//       }
//     } catch (e) {
//       EasyLoading.showError("Failed to pick an image: $e");
//     }
//   }

//   void showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt_outlined),
//               title: const Text('Choose from Camera'),
//               onTap: () {
//                 pickImage(ImageSource.camera);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_outlined),
//               title: const Text('Choose from Gallery'),
//               onTap: () {
//                 pickImage(ImageSource.gallery);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
import 'package:inprep_ai/features/home_screen/model/userinfo_model.dart';

class ProfileController extends GetxController {
  final HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;
  final RxString selectedImagePath = ''.obs;
  final RxString logoUrl = ''.obs;

  // Text controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController experiecnceController = TextEditingController();
  final TextEditingController preferredController = TextEditingController();
  final TextEditingController interviewController = TextEditingController();
  final TextEditingController confidenceController = TextEditingController();
  final TextEditingController currentplanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize text controllers with data from HomeScreenController
    updateControllers();
    // Listen for changes in userInfo to update controllers
    ever(homeScreenController.userInfo, (_) => updateControllers());
  }

  void updateControllers() {
    final userData = homeScreenController.userInfo.value?.data;
    if (userData != null) {
      fullNameController.text = userData.name ?? '';
      emailController.text = userData.email ?? '';
      experiecnceController.text = userData.experienceLevel ?? '';
      preferredController.text = userData.preferedInterviewFocus ?? '';
      interviewController.text = userData.interviewTaken?.toString() ?? '0';
      confidenceController.text = userData.confidence != null ? '${userData.confidence}%' : '0%';
      currentplanController.text = userData.currentPlan ?? 'Free Plan';
      logoUrl.value = userData.img ?? '';
    }
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      // Save logic here if needed (e.g., API call to update profile)
      saveProfile();
    }
  }

  Future<void> showImagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
      // Optionally upload the image to the server and update logoUrl
    }
  }

  Future<void> saveProfile() async {
    // Implement API call to save profile changes if needed
    // Example: Update name, experienceLevel, preferredInterviewFocus
    try {
      isLoading.value = true;
      // Add your API call logic here to update the profile
      // For example, send fullNameController.text, experiecnceController.text, etc.
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    fullNameController.dispose();
    emailController.dispose();
    experiecnceController.dispose();
    preferredController.dispose();
    interviewController.dispose();
    confidenceController.dispose();
    currentplanController.dispose();
    super.onClose();
  }
}
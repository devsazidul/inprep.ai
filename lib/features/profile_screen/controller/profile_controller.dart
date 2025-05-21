import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController experiecnceController = TextEditingController();
  final TextEditingController preferredController = TextEditingController();
  final TextEditingController interviewController = TextEditingController();
  final TextEditingController confidenceController = TextEditingController();
  final TextEditingController currentplanController = TextEditingController();

  var isEditing = false.obs;
  final logoUrl = ''.obs;
  var selectedImagePath = ''.obs;
  var hasImageChanged = false.obs;

  var originalFullName = '';
  var originalExperience = '';
  var originalPreferred = '';

  void toggleEdit() {
    if (isEditing.value || hasImageChanged.value) {
      saveChanges();
      hasImageChanged.value = false;
    } else {
      originalFullName = fullNameController.text;
      originalExperience = experiecnceController.text;
      originalPreferred = preferredController.text;
    }
    isEditing.toggle();
  }

  Future<void> saveChanges() async {
    await updateProfile(
      name: fullNameController.text,
      experienceLevel: experiecnceController.text,
      preferredInterviewFocus: preferredController.text,
    );
  }

  Future<void> updateProfile({
    required String name,
    required String experienceLevel,
    required String preferredInterviewFocus,
  }) async {
    debugPrint('Starting updateProfile...');
    debugPrint(
      'Name: $name, ExperienceLevel: $experienceLevel, PreferredInterviewFocus: $preferredInterviewFocus',
    );

    EasyLoading.show(status: "Updating profile...");

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final accessToken = prefs.getString('approvalToken');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('No access token found');
      }

      final url = Uri.parse(Urls.updateProfile);
      final request = http.MultipartRequest('PATCH', url);
      request.headers['Authorization'] = accessToken;

      request.fields['data'] = jsonEncode({
        'name': name,
        'experienceLevel': experienceLevel,
        'preferredInterviewFocus': preferredInterviewFocus,
      });

      if (selectedImagePath.value.isNotEmpty) {
        final file = File(selectedImagePath.value);
        if (await file.exists()) {
          final fileName = path.basename(file.path);
          final multipartFile = await http.MultipartFile.fromPath(
            'img',
            file.path,
            filename: fileName,
          );
          request.files.add(multipartFile);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true) {
          await _handleSuccessResponse(
            responseData,
            name,
            experienceLevel,
            preferredInterviewFocus,
          );
          EasyLoading.showSuccess("Profile updated successfully!");
        } else {
          final errorMessage =
              responseData['message'] ?? "Profile update failed";
          EasyLoading.showError(errorMessage);
          throw Exception(errorMessage);
        }
      } else {
        final errorMessage = _parseError(responseData, response.statusCode);
        EasyLoading.showError(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint('Update profile error: $e');
      EasyLoading.showError(
        'Update failed: ${e.toString().replaceAll('Exception: ', '')}',
      );
    }
  }

  Future<void> _handleSuccessResponse(
    Map<String, dynamic> data,
    String name,
    String experienceLevel,
    String preferredInterviewFocus,
  ) async {
    debugPrint('Profile update success');

    if (data['data'] != null && data['data']['img'] != null) {
      logoUrl.value = data['data']['img'];
      selectedImagePath.value = '';
      hasImageChanged.value = false;
    }

    fullNameController.text = data['data']['name'] ?? name;
    experiecnceController.text =
        data['data']['experienceLevel'] ?? experienceLevel;
    preferredController.text =
        data['data']['preferredInterviewFocus'] ?? preferredInterviewFocus;

    if (data['data']['currentPlan'] != null) {
      currentplanController.text = data['data']['currentPlan'];
    }
  }

  String _parseError(Map<String, dynamic> data, int statusCode) {
    if (data['message'] != null) {
      return data['message'];
    }

    switch (statusCode) {
      case 400:
        return 'Invalid request data';
      case 401:
        return 'Authentication failed';
      case 403:
        return 'Permission denied';
      case 404:
        return 'Profile not found';
      case 500:
        return 'Server error';
      default:
        return 'Update failed (status $statusCode)';
    }
  }

  void cancelEditing() {
    fullNameController.text = originalFullName;
    experiecnceController.text = originalExperience;
    preferredController.text = originalPreferred;
    selectedImagePath.value = '';
    isEditing.value = false;
    hasImageChanged.value = false;
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        hasImageChanged.value = true;
      } else {
        EasyLoading.showInfo("No image selected");
      }
    } catch (e) {
      EasyLoading.showError("Failed to pick an image: $e");
    }
  }

  File getSelectedImage() {
    return File(selectedImagePath.value);
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Choose from Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

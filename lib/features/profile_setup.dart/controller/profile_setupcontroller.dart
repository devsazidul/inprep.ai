import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupcontroller extends GetxController {
  TextEditingController citycontroller = TextEditingController();
  TextEditingController describecontroller = TextEditingController();
  TextEditingController summarycontroller = TextEditingController();
  TextEditingController jobtitlecontroller = TextEditingController();

  Rx<File?> selectedFile = Rx<File?>(null);
  Rx<Uint8List?> pdfPreviewImage = Rx<Uint8List?>(null);

  RxString selectedFileName = "".obs;

  // Function to pick a file from the local storage
  Future<void> pickFile() async {
    // Open the file picker dialog
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'], // Only allow PDF and DOC files
    );

    if (result != null) {
      // If a file is selected, get the file path
      PlatformFile file = result.files.single;
      selectedFileName.value = file.name; // File name to display
      selectedFile.value = File(file.path!); // Store the selected file
    } else {
      // Handle case when no file is selected
      selectedFileName.value = "No file selected";
    }
  }



//=======================================================================
  // Function to upload the file to the server
  Future<void> uploadFile() async {
    if (selectedFile.value == null) {
      debugPrint('Error: No file selected');
      EasyLoading.showError('No file selected'); // Show error with EasyLoading
      return;
    }

    // Show loading indicator
    EasyLoading.show(status: 'Uploading...');

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('approvalToken');

      debugPrint(
        'Debug: Retrieved approvalToken: $approvalToken',
      ); // Debug print the token

      // Prepare the file for uploading
      var uri = Uri.parse(
        Urls.resumeupload,
      );
      debugPrint('Debug: Request URL: $uri'); // Debug print the URL being used

      var request = http.MultipartRequest('POST', uri);

      // Adding headers (Authorization with approvalToken)
      request.headers.addAll({
        'Authorization':
            '$approvalToken', // Assuming the token needs to be in Bearer format
        'Content-Type':
            'multipart/form-data', // Specifies that the request body will be multipart
      });

      debugPrint(
        'Debug: Request Headers: ${request.headers}',
      ); // Debug print the headers

      String? mimeType = lookupMimeType(selectedFile.value!.path);
      String? fileExtension = selectedFile.value!.path.split('.').last;
      debugPrint('Debug: File Path: ${selectedFile.value!.path}');
      debugPrint('Debug: File MIME Type: $mimeType');
      debugPrint('Debug: File Extension: $fileExtension');

      // Attach the file to the request
      var file = await http.MultipartFile.fromPath(
        'resumeFile', // The key for the file field
        selectedFile.value!.path,
        contentType:
            mimeType != null ? MediaType('application', fileExtension) : null,
      );

      debugPrint(
        'Debug: File added to request: ${file.filename}',
      ); // Debug print the file info

      request.files.add(file);

      debugPrint('Debug: Sending request...');
      var response = await request.send();

      debugPrint(
        'Debug: Response status code: ${response.statusCode}',
      ); // Debug print the status code

      // Dismiss loading indicator
      EasyLoading.dismiss();

      // Check the response status
      if (response.statusCode == 200) {
        debugPrint('Debug: File uploaded successfully');
        EasyLoading.showSuccess(
          'File uploaded successfully',
        ); // Success message using EasyLoading
        Get.to(BottomNavbarView());
      } else {
        debugPrint('Debug: Failed to upload file');
        EasyLoading.showError(
          'Failed to upload file',
        ); // Error message using EasyLoading
      }
    } catch (e) {
      // Dismiss loading indicator on error
      EasyLoading.dismiss();
      debugPrint('Error: An error occurred while uploading the file: $e');
      EasyLoading.showError(
        'An error occurred while uploading the file',
      ); // Error message using EasyLoading
    }
  }


//==========================================================================
}

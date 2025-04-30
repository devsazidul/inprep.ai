import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
      selectedFileName.value = file.name;
      // You can handle the file here, such as uploading or saving the file path
    } else {
      // Handle case when no file is selected
      selectedFileName.value = "No file selected";
    }
  }
}

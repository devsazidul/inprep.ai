import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileSetupcontroller extends GetxController {
  TextEditingController citycontroller = TextEditingController();
  TextEditingController describecontroller = TextEditingController();

  Rx<File?> selectedFile = Rx<File?>(null);
  Rx<Uint8List?> pdfPreviewImage = Rx<Uint8List?>(null);

  
}

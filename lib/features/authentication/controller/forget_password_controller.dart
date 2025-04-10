import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController pinController = TextEditingController();
  TextEditingController pinController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Form validation flag
  var isFormValid2 = false.obs;
  var isFormVaid = false.obs;

  void validdateForm2() {
    isFormValid2.value = pinController.text.length == 6;
  }

  void validdateForm() {
    isFormVaid.value = pinController2.text.length == 6;
  }

  @override
  void onClose() {
    pinController.dispose();
    emailController.dispose();
    phoneController.dispose();
    pinController2.dispose();
    super.onClose();
  }
}

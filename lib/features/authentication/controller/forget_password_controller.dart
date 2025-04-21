import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var toggleValue = 0.obs;
  void toggle() {
    toggleValue.value = toggleValue.value == 0 ? 1 : 0;
  }
}

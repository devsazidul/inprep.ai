import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var toggleValue = 0.obs;
  void toggle() {
    toggleValue.value = toggleValue.value == 0 ? 1 : 0;
  }

  void forgetPassword() async {
  try {
    EasyLoading.show(status: 'Sending OTP...');

    String? email = emailController.text.trim();
    if (email.isEmpty) {
      EasyLoading.showError("Email field cannot be empty.");
      return;
    }

    final response = await http.post(
      Uri.parse(Urls.forgetPassword),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email, // Sending email to the backend
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
     
      var resetLink = responseData['body']['resetLink']; // Extract resetLink

      if (resetLink != null && resetLink.isNotEmpty) {
        // Save resetLink to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('resetLink', resetLink); // Save the resetLink

        EasyLoading.showSuccess('OTP Sent Successfully');
      }
    } else {
      var errorData = jsonDecode(response.body);
      EasyLoading.showError(errorData['message'] ?? "Failed to send OTP");
    }
  } catch (e) {
    EasyLoading.showError("Something went wrong: $e");
  } finally {
    EasyLoading.dismiss();
  }
}
}

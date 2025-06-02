import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart' show SharedPreferencesHelper;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/authentication/model/login_info.dart';
import 'package:inprep_ai/features/authentication/screen/login_otp_send_screen.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isFromValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Add listeners to validate form on every change
    emailController.addListener(validateForm);
    passwordControler.addListener(validateForm);
  }

  void validateForm() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }



  Future<void> login() async {
  EasyLoading.show(status: 'Logging in...');
  try {
    Map<String, dynamic> requestBody = {
      'email': emailController.text.trim(),
      'password': passwordControler.text.trim(),
    };

    final response = await http.post(
      Uri.parse(Urls.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    debugPrint("Response body: ${response.body}");
    debugPrint("Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final loginInfo = LoginInfo.fromJson(jsonDecode(response.body));

      if (loginInfo.approvalToken != null) {
        

        // Save tokens and user info as before
        await SharedPreferencesHelper.saveTokenAndRole(
          loginInfo.approvalToken ?? ''
        );

        EasyLoading.showSuccess(loginInfo.message ?? "Login Successful");

        // Check if OTP is verified
        if (loginInfo.user?.otpVerified == false) {
          Get.to(
            () => LoginOtpSendScreen(),
            arguments: {
              'approvalToken': loginInfo.approvalToken ?? '',
              'email': emailController.text.trim(),
            },
          );
          sendCode();
        } else if (loginInfo.meta?.isAboutMeGenerated == false) {
          Get.put(ProfileSetupcontroller());
          Get.to(() => ProfileSetup());
        } else {
          Get.offAll(() => BottomNavbarView());
        }
      } else {
        EasyLoading.showError(
          loginInfo.message ?? "Login Failed - No approval token",
        );
      }
    } else {
      try {
        final errorResponse = jsonDecode(response.body);
        EasyLoading.showError(errorResponse['message'] ?? "Login Failed");
      } catch (e) {
        EasyLoading.showError(
          "Login Failed with status code: ${response.statusCode}",
        );
      }
    }
  } catch (e) {
    EasyLoading.showError("An error occurred during login");
    debugPrint("Login Error: $e");
  } finally {
    EasyLoading.dismiss();
  }
}


  //===========================================================================================
  void sendCode() async {
    try {
      EasyLoading.show(status: 'Sending OTP...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('approvalToken');
      if (approvalToken == null || approvalToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        return;
      }
      await prefs.remove('token');
      final response = await http.post(
        Uri.parse(Urls.sendOtp),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': approvalToken,
        },
        body: jsonEncode({}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response and extract the token
        var responseData = jsonDecode(response.body);
        var token = responseData['body']['token']; // Extract token

        // Save token to SharedPreferences
        if (token != null && token.isNotEmpty) {
          await prefs.setString('token', token);
        }
        EasyLoading.showSuccess('OTP Sent Successfully');
      } else {
        // Option 2: If 401 Unauthorized, try without Bearer prefix
        if (response.statusCode == 401) {
          final retryResponse = await http.post(
            Uri.parse(Urls.sendOtp),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': approvalToken,
            },
            body: jsonEncode({}),
          );
          if (retryResponse.statusCode == 200 ||
              retryResponse.statusCode == 201) {
            var retryResponseData = jsonDecode(retryResponse.body);
            var retryToken =
                retryResponseData['body']['token']; // Extract token

            // Save token to SharedPreferences
            if (retryToken != null && retryToken.isNotEmpty) {
              await prefs.setString('authToken', retryToken);
            }
            EasyLoading.showSuccess('OTP Sent Successfully');
            return;
          }
        }
        final bodyResponse = await http.post(
          Uri.parse(Urls.sendOtp),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'approvalToken': approvalToken}),
        );
        if (bodyResponse.statusCode == 200 || bodyResponse.statusCode == 201) {
          var bodyResponseData = jsonDecode(bodyResponse.body);
          var bodyToken = bodyResponseData['body']['token'];
          if (bodyToken != null && bodyToken.isNotEmpty) {
            await prefs.setString('authToken', bodyToken);
          }
          EasyLoading.showSuccess('OTP Sent Successfully');
          return;
        }
        var errorData = jsonDecode(response.body);
        EasyLoading.showError(errorData['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //===========================================================================================

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }
}

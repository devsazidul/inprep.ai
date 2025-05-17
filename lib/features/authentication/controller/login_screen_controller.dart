import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/authentication/model/login_info.dart';
import 'package:inprep_ai/features/authentication/screen/login_otp_send_screen.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
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
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Save tokens and user info as before
          await prefs.setString('approvalToken', loginInfo.approvalToken ?? '');
          await prefs.setString('refreshToken', loginInfo.refreshToken ?? '');
          if (loginInfo.user != null) {
            await prefs.setString('userId', loginInfo.user?.sId ?? '');
            await prefs.setString('userName', loginInfo.user?.name ?? '');
            await prefs.setString('userEmail', loginInfo.user?.email ?? '');
            await prefs.setString('userPhone', loginInfo.user?.phone ?? '');
            await prefs.setString('userRole', loginInfo.user?.role ?? '');
            await prefs.setBool('isLoggedIn', true);
            await prefs.setBool(
              'otpVerified',
              loginInfo.user?.otpVerified ?? false,
            );
          }

          EasyLoading.showSuccess(loginInfo.message ?? "Login Successful");

          if (loginInfo.user?.otpVerified == false) {
            Get.to(
              () => LoginOtpSendScreen(),
              arguments: {
                'approvalToken': loginInfo.approvalToken ?? '',
                'email': emailController.text.trim(),
              },
            );
            sendCode();
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

  void sendCode() async {
    debugPrint("Entered resendCode function.");
    try {
      EasyLoading.show(status: 'Sending OTP...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('approvalToken');
      debugPrint("approvalToken retrieved: $approvalToken");

      if (approvalToken == null || approvalToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        return;
      }

      // Option 1: Authorization: Bearer <token> (default you tried)
      final response = await http.post(
        Uri.parse(Urls.sendOtp),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': approvalToken,
        },
        body: jsonEncode({}),
      );

      debugPrint("Response Body: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('OTP Sent Successfully');
      } else {
        // Option 2: If 401 Unauthorized, try without Bearer prefix
        if (response.statusCode == 401) {
          debugPrint("Trying without Bearer prefix...");
          final retryResponse = await http.post(
            Uri.parse(Urls.sendOtp),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': approvalToken,
            },
            body: jsonEncode({}),
          );
          debugPrint("Retry Response Body: ${retryResponse.body}");
          debugPrint("Retry Status Code: ${retryResponse.statusCode}");

          if (retryResponse.statusCode == 200 ||
              retryResponse.statusCode == 201) {
            EasyLoading.showSuccess('OTP Sent Successfully');
            return;
          }
        }

        // Option 3: Try sending in body
        debugPrint("Trying sending token in body...");
        final bodyResponse = await http.post(
          Uri.parse(Urls.sendOtp),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'approvalToken': approvalToken}),
        );
        debugPrint("Body Response Body: ${bodyResponse.body}");
        debugPrint("Body Response Status Code: ${bodyResponse.statusCode}");

        if (bodyResponse.statusCode == 200 || bodyResponse.statusCode == 201) {
          EasyLoading.showSuccess('OTP Sent Successfully');
          return;
        }

        // Show error from any of the above attempts
        var errorData = jsonDecode(response.body);
        EasyLoading.showError(errorData['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
      debugPrint("Error in sendCode: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }
}

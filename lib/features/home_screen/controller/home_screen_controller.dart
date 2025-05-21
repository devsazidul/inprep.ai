import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/home_screen/model/userinfo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController{
  final RxBool isLoadingUser = false.obs;
final Rx<UserInfo?> userInfo = Rx<UserInfo?>(null);

//=======================================================================================
  Future<void> getUser() async {
  try {
    isLoadingUser.value = true;
    EasyLoading.show(status: "Loading user data...");
    debugPrint("Starting getUser API call...");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("SharedPreferences instance obtained.");

    // Make sure your token key is correct - example 'Authorization' or 'accessToken'
    String? accessToken = prefs.getString('approvalToken');
    debugPrint("Access token retrieved from prefs: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('No access token found in SharedPreferences.');
    }

    // Usually, APIs require 'Bearer <token>'
    final authHeader = accessToken;
    debugPrint("Authorization header set as: $authHeader");

    final Uri url = Uri.parse(Urls.getuser);
    debugPrint("GET Request URL: $url");

    final response = await http.get(
      url,
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
    );

    debugPrint("Response status code: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      debugPrint("Response JSON decoded.");

      if (responseData['success'] == true) {
        userInfo.value = UserInfo.fromJson(responseData);
        debugPrint("UserInfo parsed successfully.");
        debugPrint("User name: ${userInfo.value?.data?.name}");
        debugPrint("User email: ${userInfo.value?.data?.email}");
      } else {
        String message = responseData['message'] ?? 'Unknown error from API';
        debugPrint("API responded with success=false: $message");
        throw Exception('Failed to fetch user data: $message');
      }
    } else {
      throw Exception('Failed to load user data, status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint("Exception caught in getUser(): $e");
    EasyLoading.showError("Failed to load user data: ${e.toString()}");
  } finally {
    isLoadingUser.value = false;
    EasyLoading.dismiss();
    debugPrint("getUser API call finished.");
  }
}




//========================================================================================



@override
  void onInit() {
    getUser();
    super.onInit();
  }

}

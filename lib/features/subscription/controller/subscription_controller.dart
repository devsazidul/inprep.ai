// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/core/urls/endpint.dart';
// import 'package:inprep_ai/features/subscription/model/allplan_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SubscriptionController extends GetxController {
//   var plans = <Datum>[].obs;
//   var sessionId = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPlans();
//   }

//   Future<void> fetchPlans() async {
//     try {
//       final response = await http.get(Uri.parse(Urls.allplan));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final allplan = Allplan.fromJson(data);
//         plans.assignAll(allplan.data);
//       } else {
//         debugPrint('Failed to load plans: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching plans: $e');
//     }
//   }

//   Future<void> createCheckoutSession(String priceId) async {
//     final url = Uri.parse(Urls.checkout);
//     debugPrint('Starting createCheckoutSession with priceId: $priceId');
//     debugPrint('API URL: $url');

//     try {
//       EasyLoading.show(status: "Processing payment...");
//       debugPrint('EasyLoading shown');

//       final prefs = await SharedPreferences.getInstance();
//       debugPrint('SharedPreferences instance obtained');

//       await prefs.reload();
//       debugPrint('SharedPreferences reloaded');

//       final accessToken = prefs.getString('approvalToken');
//       debugPrint('Access token retrieved: $accessToken');

//       if (accessToken == null || accessToken.isEmpty) {
//         debugPrint('No access token found, throwing exception');
//         throw Exception('No access token found');
//       }

//       debugPrint(
//         'Sending POST request with priceId and authorization header...',
//       );
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': accessToken,
//         },
//         body: jsonEncode({'priceId': priceId}),
//       );
//       debugPrint('Response received with status code: ${response.statusCode}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         debugPrint('Response body decoded: $data');

//         final checkoutUrlString = data['url'];
//         debugPrint('Checkout URL extracted: $checkoutUrlString');

//         final checkoutUrl = Uri.tryParse(checkoutUrlString);
//         if (checkoutUrl != null && await canLaunchUrl(checkoutUrl)) {
//           await launchUrl(checkoutUrl, mode: LaunchMode.externalApplication);
//           debugPrint('Opened checkout URL in browser');
//         } else {
//           debugPrint('Could not launch checkout URL');
//         }
//       } else {
//         debugPrint('Failed to create checkout session: ${response.body}');
//       }
//     } catch (e) {
//       debugPrint('Error creating checkout session: $e');
//     } finally {
//       EasyLoading.dismiss();
//       debugPrint('EasyLoading dismissed');
//     }
//   }

//   // Extract session ID from the URL
//   String _extractSessionIdFromUrl(String url) {
//     RegExp regExp = RegExp(r"cs_test_[a-zA-Z0-9]+");
//     var match = regExp.firstMatch(url);
//     return match?.group(0) ?? '';
//   }
// }

import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/subscription/model/allplan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:inprep_ai/routes/app_routes.dart';

class SubscriptionController extends GetxController {
  var plans = <Datum>[].obs;
  var sessionId = ''.obs;
  var isPaymentInProgress = false.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('SubscriptionController initialized');
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    debugPrint('fetchPlans started');
    try {
      EasyLoading.show(status: 'Loading plans...');
      debugPrint('EasyLoading shown for loading plans');

      final response = await http.get(Uri.parse(Urls.allplan));
      debugPrint('HTTP GET ${Urls.allplan} responded with status ${response.statusCode}');

      EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed after loading plans');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final allplan = Allplan.fromJson(data);
        plans.assignAll(allplan.data);
        debugPrint('Plans fetched and assigned: ${plans.length} items');
      } else {
        debugPrint('Failed to load plans with status code: ${response.statusCode}');
        EasyLoading.showError('Failed to load plans');
      }
    } catch (e) {
      EasyLoading.dismiss();
      debugPrint('Exception in fetchPlans: $e');
      EasyLoading.showError('Error fetching plans');
    }
  }

  Future<void> createCheckoutSession(String priceId) async {
    debugPrint('createCheckoutSession called with priceId: $priceId');
    final url = Uri.parse(Urls.checkout);
    debugPrint('Checkout API URL: $url');

    try {
      EasyLoading.show(status: "Processing payment...");
      debugPrint('EasyLoading shown for payment processing');
      isPaymentInProgress.value = true;
      debugPrint('isPaymentInProgress set to true');

      final prefs = await SharedPreferences.getInstance();
      debugPrint('SharedPreferences instance obtained');

      await prefs.reload();
      debugPrint('SharedPreferences reloaded');

      final accessToken = prefs.getString('approvalToken');
      debugPrint('Access token retrieved: $accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('No access token found, aborting createCheckoutSession');
        EasyLoading.showError('Authentication required');
        isPaymentInProgress.value = false;
        debugPrint('isPaymentInProgress set to false due to missing token');
        return;
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: jsonEncode({'priceId': priceId}),
      );
      debugPrint('POST request sent to checkout URL, status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Response body decoded: $data');

        final checkoutUrlString = data['url'];
        debugPrint('Checkout URL extracted: $checkoutUrlString');

        final session = _extractSessionIdFromUrl(checkoutUrlString);
        debugPrint('Session ID extracted from URL: $session');

        if (session.isNotEmpty) {
          sessionId.value = session;
          debugPrint('sessionId observable updated');
        }

        final checkoutUrl = Uri.tryParse(checkoutUrlString);
        if (checkoutUrl != null && await canLaunchUrl(checkoutUrl)) {
          debugPrint('Launching checkout URL...');
          await launchUrl(checkoutUrl, mode: LaunchMode.externalApplication);
          debugPrint('Checkout URL launched in external browser');
        } else {
          debugPrint('Could not launch checkout URL');
          EasyLoading.showError('Failed to open payment gateway');
        }
      } else {
        debugPrint('Failed to create checkout session: ${response.body}');
        EasyLoading.showError('Payment session creation failed');
      }
    } catch (e) {
      debugPrint('Exception in createCheckoutSession: $e');
      EasyLoading.showError('An error occurred');
    } finally {
      EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed after createCheckoutSession');
      isPaymentInProgress.value = false;
      debugPrint('isPaymentInProgress set to false');
    }
  }

  String _extractSessionIdFromUrl(String url) {
    debugPrint('Extracting session ID from URL: $url');
    RegExp regExp = RegExp(r"cs_test_[a-zA-Z0-9]+");
    var match = regExp.firstMatch(url);
    final extracted = match?.group(0) ?? '';
    debugPrint('Extracted session ID: $extracted');
    return extracted;
  }

  Future<void> verifyPayment() async {
    debugPrint('verifyPayment started');
    if (sessionId.value.isEmpty) {
      debugPrint('No session ID available for verification');
      EasyLoading.showError('No payment session to verify');
      return;
    }

    final String apiUrl = '${Urls.paymentsave}${sessionId.value}';
    debugPrint('Verifying payment with API URL: $apiUrl');

    try {
      EasyLoading.show(status: 'Verifying payment...');
      debugPrint('EasyLoading shown for payment verification');

      final prefs = await SharedPreferences.getInstance();
      debugPrint('SharedPreferences instance obtained for verification');

      await prefs.reload();
      debugPrint('SharedPreferences reloaded for verification');

      final accessToken = prefs.getString('approvalToken');
      debugPrint('Access token retrieved for verification: $accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('No access token found, aborting verifyPayment');
        EasyLoading.showError('Authentication required');
        isPaymentInProgress.value = false;
        debugPrint('isPaymentInProgress set to false due to missing token');
        return;
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );
      debugPrint('Verification response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Payment verified successfully!');
        isPaymentInProgress.value = false;
        debugPrint('Payment verified successfully, navigating...');
        Get.toNamed(AppRoute.bottomnavbarview);
      } else {
        debugPrint('Payment verification failed: ${response.body}');
        EasyLoading.showError('Payment verification failed');
      }
    } catch (e) {
      debugPrint('Exception in verifyPayment: $e');
      EasyLoading.showError('Error verifying payment');
    } finally {
      EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed after verifyPayment');
    }
  }
}

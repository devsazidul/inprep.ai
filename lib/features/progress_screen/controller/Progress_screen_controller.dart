// import 'package:flutter/cupertino.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart' hide Progress;
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/core/urls/endpint.dart';
// import 'package:inprep_ai/features/progress_screen/model/progress_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProgressScreenController extends GetxController {
//   // Observable to hold the parsed Progress data
//   var progress = Rxn<Progress>();

//   Future<void> fetchAverageData() async {
//     final Uri url = Uri.parse(Urls.graph);

//     try {
//       debugPrint('DEBUG: Starting fetchAverageData function');
//       EasyLoading.show(status: "Fetching average data...");
//       debugPrint(
//         'DEBUG: EasyLoading shown with status "Fetching average data..."',
//       );

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       debugPrint('DEBUG: SharedPreferences instance obtained');
//       String? accessToken = prefs.getString('approvalToken');
//       debugPrint('DEBUG: Access token retrieved: $accessToken');

//       if (accessToken == null || accessToken.isEmpty) {
//         debugPrint('DEBUG: Access token is null or empty, throwing exception');
//         throw Exception('No access token found.');
//       }

//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': accessToken,
//           'Content-Type': 'application/json',
//         },
//       );

//       debugPrint('DEBUG: HTTP GET request sent');
//       debugPrint('DEBUG: Response status code: ${response.statusCode}');
//       debugPrint('DEBUG: Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         // Parse the JSON response into Progress model
//         final fetchedProgress = progressFromJson(response.body);
//         progress.value = fetchedProgress; // Update the observable
//         debugPrint('DEBUG: Progress data parsed successfully');
//       } else {
//         debugPrint(
//           'DEBUG: Failed to fetch data - Status: ${response.statusCode}, Body: ${response.body}',
//         );
//         EasyLoading.showError('Failed to fetch data: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('DEBUG: Error caught in fetchAverageData: $e');
//       EasyLoading.showError('Error fetching data: $e');
//     } finally {
//       debugPrint('DEBUG: Dismissing EasyLoading');
//       EasyLoading.dismiss();
//     }
//   }

//   @override
//   void onInit() {
//     fetchAverageData();
//     super.onInit();
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Progress;
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/progress_screen/model/progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressScreenController extends GetxController {
  // Observable to hold the parsed Progress data
  var progress = Rxn<Progress>();

  Future<void> fetchAverageData() async {
    final Uri url = Uri.parse(Urls.graph);

    try {
      debugPrint('DEBUG: Starting fetchAverageData function');
      EasyLoading.show(status: "Fetching average data...");
      debugPrint('DEBUG: EasyLoading shown with status "Fetching average data..."');

      // Getting the access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint('DEBUG: SharedPreferences instance obtained');
      String? accessToken = prefs.getString('approvalToken');
      debugPrint('DEBUG: Access token retrieved: $accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('DEBUG: Access token is null or empty, throwing exception');
        throw Exception('No access token found.');
      }

      // Sending the HTTP request
      final response = await http.get(
        url,
        headers: {
          'Authorization': accessToken,  // Make sure you send the token as Bearer token
          'Content-Type': 'application/json',
        },
      );

      debugPrint('DEBUG: HTTP GET request sent');
      debugPrint('DEBUG: Response status code: ${response.statusCode}');
      debugPrint('DEBUG: Response body: ${response.body}');

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON response into the Progress model
        final fetchedProgress = progressFromJson(response.body);
        progress.value = fetchedProgress;  // Update the observable
        debugPrint('DEBUG: Progress data parsed successfully');
      } else {
        // If the response status is not 200, show error
        debugPrint('DEBUG: Failed to fetch data - Status: ${response.statusCode}, Body: ${response.body}');
        EasyLoading.showError('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('DEBUG: Error caught in fetchAverageData: $e');
      EasyLoading.showError('Error fetching data: $e');
    } finally {
      debugPrint('DEBUG: Dismissing EasyLoading');
      EasyLoading.dismiss();  // Always dismiss the loading indicator
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAverageData();  // Fetch data when the controller is initialized
  }
}

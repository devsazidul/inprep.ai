// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Progress;
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/progress_screen/model/progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressScreenController extends GetxController {
  var progress = Rxn<Progress>();

  Future<void> fetchAverageData() async {
    final Uri url = Uri.parse(Urls.graph);
    try {
      debugPrint('DEBUG: Starting fetchAverageData function');
      EasyLoading.show(status: "Fetching average data...");
      debugPrint(
        'DEBUG: EasyLoading shown with status "Fetching average data..."',
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint('DEBUG: SharedPreferences instance obtained');
      String? accessToken = prefs.getString('approvalToken');
      debugPrint('DEBUG: Access token retrieved: $accessToken');
      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('DEBUG: Access token is null or empty, throwing exception');
        throw Exception('No access token found.');
      }
      final response = await http.get(
        url,
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );
      debugPrint('DEBUG: HTTP GET request sent');
      debugPrint('DEBUG: Response status code: ${response.statusCode}');
      debugPrint('DEBUG: Response body: ${response.body}');
      if (response.statusCode == 200) {
        final fetchedProgress = progressFromJson(response.body);
        progress.value = fetchedProgress;
        debugPrint('DEBUG: Progress data parsed successfully');
      } else {
        debugPrint(
          'DEBUG: Failed to fetch data - Status: ${response.statusCode}, Body: ${response.body}',
        );
        EasyLoading.showError('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('DEBUG: Error caught in fetchAverageData: $e');
      EasyLoading.showError('Error fetching data: $e');
    } finally {
      debugPrint('DEBUG: Dismissing EasyLoading');
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAverageData();
  }
}

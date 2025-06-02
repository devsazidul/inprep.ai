import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart' show Urls;
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/interview/interview_lists/moddel/interview_model.dart' show Interview, MockInterviewResponse;

class InterviewListController extends GetxController {
  var searchController = TextEditingController(); 

  List <Map<String, dynamic>> incompleteSessions = [
    {
      "title": "Software Developer Interview",
      "positions": 11,
      "color": Color(0xFFFFEB3B),
      "image": ImagePath.image1,
    },
    {
      "title": "Product Manager Interview",
      "positions": 7,
      "color": Color(0xFF9DFF3B),
      "image": ImagePath.image2,
    },
    {
      "title": "UX Designer Interview",
      "positions": 5,
      "color": Color(0xFF3BCEFF),
      "image": ImagePath.image1,
    },
  ];

  List <Map<String, dynamic>> availableMockInterviews = [
    {
      "title": "Software Developer Interview",
      "positions": 11,
      "image": ImagePath.image2,
    },
    {
      "title": "Product Manager Interview",
      "positions": 7,
    
      "image": ImagePath.image3,
    },
    {
      "title": "Data Scientist Interview",
      "positions": 5,
      "image": ImagePath.image4,
    },
    {
      "title": "UX Designer Interview",
      "positions": 5,
      "image": ImagePath.image5,
    },
    {
      "title": "DevOps Engineer Interview",
      "positions": 5,
      "image": ImagePath.image6,
    },
    {
      "title": "Marketing Specialist Interview",
      "positions": 5,
      "image": ImagePath.image7,
    },
    {
      "title": "Cybersecurity Analyst Interview",
      "positions": 5,
      "image": ImagePath.image8,
    },
    {
      "title": "Sales Engineer Interview",
      "positions": 5,
      "image": ImagePath.image9,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    fetchMockInterviews();
  }


  var isLoading = false.obs;
  var allInterviews = <Interview>[].obs;
  var suggestedInterviews = <Interview>[].obs;

  Future<void> fetchMockInterviews() async {
    try {
      isLoading(true);
      String? token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/interview/get_mock_interview'),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print("The interviews are: ${response.body}");
      } 

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final mockResponse = MockInterviewResponse.fromJson(data);

        allInterviews.assignAll(mockResponse.body.allInterviews);
        suggestedInterviews.assignAll(mockResponse.body.suggested);
      } else {
        Get.snackbar("Error", "Failed to load interviews: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
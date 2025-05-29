import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/subscription/model/allplan_model.dart';

class SubscriptionController extends GetxController {
  final List<Map<String, dynamic>> subscriptionList = [
    {
      "name": "Free Plan",
      "description": "Lorem ipsum dolor sit amet consectetur. At interdum euismod ac cras mauris. Maecenas egestas cursus integer porttitor amet.", 
      "price": 0,
      "limit": "monthly",
      "included": [
        "1 Free Mock Interview",
        "Track up to 10 Jobs per month",
        "Personalized Feedback", 
        "Access to AI Feedback 1 Interview",
        "Progress Tracking",
        "Recommendation for Improvement"
      ],
    },
    {
      "name": "Premium Plan",
      "description": "Lorem ipsum dolor sit amet consectetur. At interdum euismod ac cras mauris. Maecenas egestas cursus integer porttitor amet.", 
      "price": 19.99,
      "limit": "monthly",
      "included": [
        "10 Mock Interviews",
        "Unlimited Jobs Tracking",
        "Personalized Feedback", 
        "Access to AI Feedback 10 Interview", 
        "Generate Custom Mock Interview", 
        "Progress Tracking", 
        "Recommendation for Improvement"
      ],
    },
    {
      "name": "Pay-Per-Interview",
      "description": "Lorem ipsum dolor sit amet consectetur. At interdum euismod ac cras mauris. Maecenas egestas cursus integer porttitor amet.", 
      "price": 4.99,
      "limit": "per-interview",
      "included": [
        "Unlimited Jobs Tracking",
        "Personalized Feedback", 
        "Access to AI Feedback", 
        "Generate Custom Mock Interview", 
        "Progress Tracking", 
        "Recommendation for Improvement"
      ],
    },
  ];


Future<void> fetchPlans() async {
  final url = Urls.allplan;

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the response body to the Allplan model
      final data = json.decode(response.body);
      final allplan = Allplan.fromJson(data);
      // Handle your allplan data here as needed, for example:
      debugPrint('Plans data fetched successfully');
      debugPrint('Message: ${allplan.message}');
      debugPrint('Number of plans: ${allplan.data.length}');
    } else {
      debugPrint('Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  } catch (error) {
    debugPrint('Error: $error');
    throw Exception('Error: $error');
  }
}

@override
  void onInit() {
    fetchPlans();
    super.onInit();
  }
}

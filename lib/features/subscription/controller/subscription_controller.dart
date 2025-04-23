import 'package:get/get_state_manager/get_state_manager.dart';

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
}
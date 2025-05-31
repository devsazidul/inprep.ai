import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/subscription/model/allplan_model.dart';

class SubscriptionController extends GetxController {
  var plans = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    try {
      final response = await http.get(Uri.parse(Urls.allplan));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final allplan = Allplan.fromJson(data);
        plans.assignAll(allplan.data);
      } else {
        debugPrint('Failed to load plans: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching plans: $e');
    }
  }
}

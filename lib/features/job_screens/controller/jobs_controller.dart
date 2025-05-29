import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inprep_ai/features/job_screens/models/all_jobs_model.dart';

class JobsController extends GetxController {
  // Job related observables
  var jobsmodel = <AllJobsModel>[].obs;
  var filteredJobs = <AllJobsModel>[].obs;
  var isLoading = true.obs;
  
  // Search controller
  final searchController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    alljobs();
    
    // Add listener to search controller
    searchController.addListener(() {
      filterJobs(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> alljobs() async {
    final url = Urls.alljob;

    try {
      isLoading(true);
      EasyLoading.show(status: "Fetching Jobs...");

      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final accessToken = prefs.getString('approvalToken');

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': accessToken},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        jobsmodel.value = data.map((item) => AllJobsModel.fromJson(item)).toList();
        filteredJobs.assignAll(jobsmodel);
      }
    } catch (error) {
      debugPrint('Error: $error');
    } finally {
      isLoading(false);
      EasyLoading.dismiss();
    }
  }

  void filterJobs(String query) {
    if (query.isEmpty) {
      filteredJobs.assignAll(jobsmodel);
    } else {
      filteredJobs.assignAll(jobsmodel.where((job) =>
          job.title?.toLowerCase().contains(query.toLowerCase()) == true ||
          job.company?.toLowerCase().contains(query.toLowerCase()) == true ||
          job.location?.toLowerCase().contains(query.toLowerCase()) == true));
    }
  }
}
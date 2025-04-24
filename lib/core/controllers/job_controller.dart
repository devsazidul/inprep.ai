import 'package:get/get.dart';
import 'package:inprep_ai/core/models/job_model.dart';

class JobController extends GetxController {
  var jobs =
      [
        Job(
          "Software Developer",
          "Tech Innovators Inc.",
          "San Francisco, CA",
          "April 10, 2025",
          false,
        ),
        Job(
          "Product Manager",
          "Creative Solutions LLC",
          "Austin, TX",
          "May 15, 2025",
          true,
        ),
        Job("UX Designer", "Design Co.", "New York, NY", "June 20, 2025", true),
        Job(
          "Data Analyst",
          "Insightful Data",
          "Chicago, IL",
          "July 1, 2025",
          false,
        ),
        Job(
          "Marketing Specialist",
          "Brand Builders",
          "Los Angeles, CA",
          "August 5, 2025",
          true,
        ),
      ].obs;
}

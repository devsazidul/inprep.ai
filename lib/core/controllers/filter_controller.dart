import 'package:get/get.dart';

class FilterController extends GetxController {
  final companies = ['Tech Innovators Inc.', 'Dev Solutions', 'Creative Coders'].obs;
  final positions = ['Product Manager', 'Software Engineer', 'UI/UX Designer'].obs;
  final years = ['2023', '2024', '2025'].obs;
  final locations = ['New York, NY', 'Chicago, IL', 'San Francisco, CA'].obs;
  final statuses = ['Applied', 'Interviewing', 'Hired'].obs;

  var selectedCompany = 'Tech Innovators Inc.'.obs;
  var selectedPosition = 'Product Manager'.obs;
  var selectedYear = '2025'.obs;
  var selectedLocation = 'Chicago, IL'.obs;
  var selectedStatus = 'Applied'.obs;
}

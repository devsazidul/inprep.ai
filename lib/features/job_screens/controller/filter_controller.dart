import 'package:get/get.dart';
import 'package:inprep_ai/features/job_screens/models/all_jobs_model.dart';

class FilterController extends GetxController {
  var companies = <String>[].obs;
  var positions = <String>[].obs;
  var years = <String>[].obs;
  var locations = <String>[].obs;
  var statuses = <String>[].obs;

  var selectedCompany = ''.obs;
  var selectedPosition = ''.obs;
  var selectedYear = ''.obs;
  var selectedLocation = ''.obs;
  var selectedStatus = ''.obs;

  void setFiltersFromJobs(List<AllJobsModel> jobs) {
    companies.value = jobs
        .map((job) => job.company ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    positions.value = jobs
        .map((job) => job.title ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    // Extract years from createdAt field (if not null)
    years.value = jobs
        .map((job) {
          if (job.createdAt == null) return '';
          return job.createdAt!.substring(0, 4); // get year part only
        })
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    locations.value = jobs
        .map((job) => job.location ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    statuses.value = ['Applied', 'Not Applied'];

    // Set default selections (first element or empty)
    selectedCompany.value = companies.isNotEmpty ? companies.first : '';
    selectedPosition.value = positions.isNotEmpty ? positions.first : '';
    selectedYear.value = years.isNotEmpty ? years.first : '';
    selectedLocation.value = locations.isNotEmpty ? locations.first : '';
    selectedStatus.value = statuses.first;
  }
}

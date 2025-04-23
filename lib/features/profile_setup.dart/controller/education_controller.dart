import 'package:get/get.dart';

class EducationController extends GetxController {
  // Observable variable to track the number of education rows
  var rowCount = 1.obs; // Start with 1 education row

  // Observable variable to track the number of certificate upload widgets
  var certificateCount = 1.obs; // Start with 1 certificate upload widget
  var awardCount = 1.obs;

  // Maximum number of education rows allowed
  static const int maxRows = 3;

  // Maximum number of certificate upload widgets allowed
  static const int maxCertificates = 3;
  static const int maxAwards = 3;

  // Method to add a new education row
  void addRow() {
    if (rowCount.value < maxRows) {
      rowCount.value++;
    } else {
      Get.snackbar(
        'Limit Reached',
        'You can add up to $maxRows education entries only.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Method to add a new certificate upload widget
  void addCertificate() {
    if (certificateCount.value < maxCertificates) {
      certificateCount.value++;
    } else {
      Get.snackbar(
        'Limit Reached',
        'You can add up to $maxCertificates certificates only.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void addAwards() {
    if (awardCount.value < maxAwards) {
      awardCount.value++;
    } else {
      Get.snackbar(
        'Limit Reached',
        'You can add up to $maxAwards only.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}

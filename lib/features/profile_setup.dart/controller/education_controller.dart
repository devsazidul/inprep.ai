import 'package:file_picker/file_picker.dart';
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
  @override
  void onInit() {
    super.onInit();
    // Initialize the list with empty strings when adding certificates
    selectedFileNames.add("");
  }

  // Method to add a new certificate upload widget
  // void addCertificate() {
  //   if (certificateCount.value < maxCertificates) {
  //     certificateCount.value++;
  //   } else {
  //     Get.snackbar(
  //       'Limit Reached',
  //       'You can add up to $maxCertificates certificates only.',
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
  void addCertificate() {
    if (certificateCount.value < maxCertificates) {
      certificateCount.value++;
      selectedFileNames.add(null); // Add null for new certificate slot
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




  RxList<String?> selectedFileNames = <String?>[null].obs;

  // Function to pick a file from the local storage
  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpeg', 'jpg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;
      // Ensure the list is big enough
      while (index >= selectedFileNames.length) {
        selectedFileNames.add(null);
      }
      selectedFileNames[index] = file.name;
    }
  }


  var selectDate = 'DD.MM.YYYY'.obs;
  void updateDate2(String date) {
    selectDate.value = date;
  }

  // End date
  var selectDate1 = 'DD.MM.YYYY'.obs;
  void updateDate3(String date) {
    selectDate1.value = date;
  }
}

import 'package:get/get.dart';

class ExperienceController extends GetxController {
  // Start date
  var selectDate = 'DD.MM.YYYY'.obs;
  void updateStartDate(String date) {
    selectDate.value = date;
  }

  // End date
  var selectDate1 = 'DD.MM.YYYY'.obs;
  void updateEndDate(String date) {
    selectDate1.value = date;
  }
}
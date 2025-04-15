import 'package:get/get.dart';

class CategoryDetailsController extends GetxController {
  var title = ''.obs;
  var description =
      'Lorem ipsum dolor sit amet consectetur. Mi accumsan orci aenean libero aenean. In risus purus ipsum nibh leo. Malesuada fames enim feugiat enim. Dolor aliquam libero facilisi nunc eget justo ante.'
          .obs;

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments; 
  }

  List<Map<String, dynamic>> whattoexpect = [
     {
      'title': '5 technical coding questions', 
     }, 
     {
      'title': '3 problem-solving exercises', 
     }, 
     {
      'title': 'Timed responses: 2 minutes per question', 
     }, 
     {
      'title': 'Feedback will be provided after each question', 
     }, 
  ]; 
}
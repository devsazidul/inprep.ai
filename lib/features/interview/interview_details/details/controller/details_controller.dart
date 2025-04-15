import 'package:get/get.dart';

class DetailsController extends GetxController {
  var title = ''.obs;
  var image = ''.obs;
  var positions = 0.obs;
  var description =
      'Lorem ipsum dolor sit amet consectetur. Mi accumsan orci aenean libero aenean. In risus purus ipsum nibh leo. Malesuada fames enim feugiat enim. Dolor aliquam libero facilisi nunc eget justo ante.'
          .obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is List) {
      List<dynamic> arguments = Get.arguments;
      if (arguments.length >= 3) {
        title.value = arguments[0] is String ? arguments[0] : '';
        image.value = arguments[1] is String ? arguments[1] : '';
        positions.value = arguments[2] is int ? arguments[2] : 0;
      }
    }
  }


  List<Map<String, dynamic>> categoryList = [
    {
      'title': 'Frontend Developer', 
    }, 
    {
      'title': 'Backend Developer', 
    }, 
    {
      'title': 'Full Stack Developer', 
    }, 
    {
      'title': 'Mobile App Developer', 
    }, 
    {
      'title': 'Software Engineer in Test', 
    }, 
    {
      'title': 'UI/UX Developer', 
    }, 
  ]; 
}

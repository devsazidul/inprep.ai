import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart' show ImagePath;

class PersonalizedInterviewersController extends GetxController {
 var isSubscribed = false.obs; 
 
  List <Map<String, dynamic>> availableMockInterviews = [
    {
      "title": "Software Developer Interview",
      "positions": 11,
      "image": ImagePath.image2,
    },
    {
      "title": "Product Manager Interview",
      "positions": 7,
    
      "image": ImagePath.image3,
    },
    {
      "title": "Data Scientist Interview",
      "positions": 5,
      "image": ImagePath.image4,
    },
    {
      "title": "UX Designer Interview",
      "positions": 5,
      "image": ImagePath.image5,
    },
  
  ];
}
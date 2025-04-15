import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart';

class InterviewListController extends GetxController {
  var searchController = TextEditingController(); 

  List <Map<String, dynamic>> incompleteSessions = [
    {
      "title": "Software Developer Interview",
      "positions": 11,
      "color": Color(0xFFFFEB3B),
      "image": ImagePath.image1,
    },
    {
      "title": "Product Manager Interview",
      "positions": 7,
      "color": Color(0xFF9DFF3B),
      "image": ImagePath.image2,
    },
    {
      "title": "UX Designer Interview",
      "positions": 5,
      "color": Color(0xFF3BCEFF),
      "image": ImagePath.image1,
    },
  ];

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
    {
      "title": "DevOps Engineer Interview",
      "positions": 5,
      "image": ImagePath.image6,
    },
    {
      "title": "Marketing Specialist Interview",
      "positions": 5,
      "image": ImagePath.image7,
    },
    {
      "title": "Cybersecurity Analyst Interview",
      "positions": 5,
      "image": ImagePath.image8,
    },
    {
      "title": "Sales Engineer Interview",
      "positions": 5,
      "image": ImagePath.image9,
    },
  ];
}
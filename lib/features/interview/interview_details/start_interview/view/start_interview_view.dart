import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';

class StartInterviewView extends StatelessWidget {
   StartInterviewView({super.key});

  final StartInterviewController controller = Get.put(StartInterviewController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
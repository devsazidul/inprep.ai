import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';

class InterviewListView extends StatelessWidget {
   InterviewListView({super.key});

  final InterviewListController controller = Get.put(InterviewListController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
    );
  }
}
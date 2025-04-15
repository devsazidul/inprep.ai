import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';
import 'package:inprep_ai/features/interview/interview_lists/lists/incomplete_sessions.dart' show IncompleteSessions;
import 'package:inprep_ai/features/interview/interview_lists/widgets/search_textfield.dart';

class InterviewListView extends StatelessWidget {
   InterviewListView({super.key});

  final InterviewListController controller = Get.put(InterviewListController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
    
      body: Padding(
        padding: EdgeInsets.only(     
          top: 70,
          left: 20, 
          right: 20, 
        ), 
        child: Column(
          children: [
            CustomTextField(
              hintText: "Search Interview ... ", 
              controller: controller.searchController, 
              suffixIcon: Icon(
                Icons.search, 
                size: 28, 
                color: Color(0xFFABB7C2),
                ),
              ),
              SizedBox(
                height: 20, 
              ), 
              IncompleteSessions(), 
          ],
        ),
      
      ),
    );
  }
}
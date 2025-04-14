import 'package:flutter/material.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Text("Interview Screen"),
      ),
    );
  }
}
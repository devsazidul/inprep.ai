import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Ready to Land \n Your Dream Job?",
              style: getTextStyle(
                
              ),
              )
            ],
          ),
        )
        )
    );
  }
}
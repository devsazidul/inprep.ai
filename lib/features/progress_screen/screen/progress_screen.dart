import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Progress & Insights",
                          style: getTextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff212121),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "8",
                          style: getTextStyle(
                            color: Color(0xff37B874),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Total Interviews",
                          style: getTextStyle(
                            color: Color(0xff878788),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Interview Progress",
                    style: getTextStyle(
                      color: Color(0xff212121),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 152,
                  
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

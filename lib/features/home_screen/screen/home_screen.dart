import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/progress_screen/screen/line_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(backgroundColor: AppColors.primaryBackground),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "   Ready to Land \nYour Dream Job?",
                    style: getTextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff212121),
                      lineHeight: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Image.asset(ImagePath.interview, height: 200, width: 200),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.66,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff37B874),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Start Mock Interview",
                              style: getTextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.pause,
                              size: 24,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Interview Progress",
                    style: getTextStyle(
                      color: const Color(0xff212121),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 152,
                  width: double.infinity,
                  child: CustomPaint(painter: LineChartPainter()),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

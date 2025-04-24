import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';

// ignore: must_be_immutable
class Experience extends StatelessWidget {
  Experience({super.key});
  final ProfileSetupcontroller profileSetupcontroller = Get.find<ProfileSetupcontroller>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Exprience",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff212121),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Describe",
                  style: getTextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),

                SizedBox(height: 10),
                Text(
                  "Experience",
                  style: getTextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: '2 Years',
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  items:
                      ['1 Year', '2 Years', '3+ Years']
                          .map(
                            (time) => DropdownMenuItem(
                              value: time,
                              child: Text(time),
                            ),
                          )
                          .toList(),
                  onChanged: (_) {},
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

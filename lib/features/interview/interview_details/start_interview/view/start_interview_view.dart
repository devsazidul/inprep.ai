import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/widget/next_button.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart' show BottomNavbarView;

class StartInterviewView extends StatelessWidget {
  StartInterviewView({super.key});

  final StartInterviewController controller = Get.put(
    StartInterviewController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Question ${controller.questionNumber.value} Out of ${controller.questions.length.toString()}',
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    Get.offAll(()=> BottomNavbarView()); 
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black.withValues(alpha: 0.3),
                    child: Center(
                      child: Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ), 
            Obx(
              () => Text(
                'Q. ${controller.questions[controller.questionNumber.value - 1]['question']}',
                style: getTextStyle(
                  color: Color(0xFF278352), 
                  fontSize: 20, 
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    controller.isCameraInitialized.value
                        ? AspectRatio(
                          aspectRatio:
                              controller.cameraController!.value.aspectRatio,
                          child: CameraPreview(controller.cameraController!),
                        )
                        : Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
              ),
            ),
            SizedBox(
              height: 20,
            ), 
            NextButton(
              onTap: controller.onNextQuestion,
            ),
          ],
        ),
      ),
    );
  }
}

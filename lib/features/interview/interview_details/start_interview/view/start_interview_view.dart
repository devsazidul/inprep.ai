
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';

class StartInterviewView extends StatelessWidget {
  StartInterviewView({super.key});

  final StartInterviewController controller = Get.put(StartInterviewController()); 
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('Interview Question')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.questions.isEmpty) {
          return Center(child: Text('No questions available'));
        }

        final question = controller.questions[controller.currentQuestionIndex.value];

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                question['question'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: controller.cameraController != null &&
                      controller.cameraController!.value.isInitialized
                  ? CameraPreview(controller.cameraController!)
                  : Center(child: Text('Camera not initialized')),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (controller.isRecording.value) {
                    controller.stopRecording();
                  } else {
                    controller.startRecording();
                  }
                },
                child: Text(controller.isRecording.value ? 'Stop Recording' : 'Start Recording'),
              ),
            ),
          ],
        );
      }),
    );
  }
}

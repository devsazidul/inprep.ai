import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
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

        // Check if history is available
        if (controller.history.isNotEmpty) {
          final historyItem = controller.history[0]; // Display the first history item
          final assessment = historyItem['assessment'];

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Previous Interview Feedback',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildFeedbackSection(
                  'Articulation',
                  assessment['Articulation']['feedback'],
                  assessment['Articulation']['score'].toString(),
                ),
                _buildFeedbackSection(
                  'Behavioral Cue',
                  assessment['Behavioural_Cue']['feedback'],
                  assessment['Behavioural_Cue']['score'].toString(),
                ),
                _buildFeedbackSection(
                  'Problem Solving',
                  assessment['Problem_Solving']['feedback'],
                  assessment['Problem_Solving']['score'].toString(),
                ),
                _buildFeedbackSection(
                  'Inprep Score',
                  '',
                  assessment['Inprep_Score']['total_score'].toString(),
                ),
                _buildFeedbackSection(
                  'What Can I Do Better',
                  assessment['what_can_i_do_better']['overall_feedback'],
                  '',
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Clear history to show questions again or proceed
                      controller.history.clear();
                      Get.offNamed('/startInterviewScreen'); // Refresh the screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Continue to Questions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Existing UI when no history or questions are available
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
            Obx(
              () => controller.isRecording.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Time left: ${controller.timeLeft.value}s',
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Expanded(
              child: controller.cameraController != null &&
                      controller.cameraController!.value.isInitialized
                  ? CameraPreview(controller.cameraController!)
                  : Center(child: Text('Camera not initialized')),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.isRecording.value) {
                      controller.stopRecording();
                    } else {
                      controller.startRecording();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    controller.isRecording.value ? 'Stop Recording' : 'Start Recording',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildFeedbackSection(String title, String feedback, String score) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (feedback.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                feedback,
                style: TextStyle(fontSize: 16),
              ),
            ],
            if (score.isNotEmpty && score != '0') ...[
              SizedBox(height: 8),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
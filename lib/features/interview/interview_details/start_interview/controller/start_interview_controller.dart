import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/model/user_model.dart';
import 'package:camera/camera.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/over_all_feedback.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/question_wise_feedback.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/start_interview_view.dart';
import 'package:path_provider/path_provider.dart';

class StartInterviewController extends GetxController {
  var questions = <Map<String, dynamic>>[].obs;
  var currentQuestionIndex = 0.obs;
  var isLoading = false.obs;
  CameraController? cameraController;
  var isRecording = false.obs;
  String? videoPath;
  var questionNumber = 1.obs;
  var id = "".obs;
  var interviewId = "".obs;
  RxString userId = ''.obs;
  var lastResponse = {}.obs;

  @override
  void onInit() {
    super.onInit();

    // ✅ Safely extract and validate Get.arguments
    final args = Get.arguments;
    if (args == null || args is! List || args.length < 2) {
      Get.snackbar('Error', 'Invalid or missing arguments passed to the interview');
      return;
    }

    id.value = args[0];
    interviewId.value = args[1];

    if (kDebugMode) {
      print("The id is: ${id.value}");
      print("The interviewId is: ${interviewId.value}");
    }

    fetchUserProfile();
    fetchQuestions();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await cameraController!.initialize();
    update();
  }

  Future<void> fetchQuestions() async {
    isLoading.value = true;
    try {
      String? token = await SharedPreferencesHelper.getAccessToken();
      if (token == null) {
        Get.snackbar('Error', 'Token is null');
        return;
      }
      final response = await http.get(
        Uri.parse(
            'https://ai-interview-server-s2a5.onrender.com/api/v1/interview/genarateQuestionSet_ByAi?questionBank_id=${id.value}'),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final remainingQuestions = data['body']['remainingQuestions'];

        if (remainingQuestions != null && remainingQuestions is List) {
          questions.value = List<Map<String, dynamic>>.from(remainingQuestions);
        } else {
          questions.clear();
          Get.snackbar('Notice', 'No questions found in the response.');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch questions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch questions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> startRecording() async {
    if (!cameraController!.value.isInitialized || isRecording.value) return;

    try {
      final directory = await getTemporaryDirectory();
      videoPath =
          '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      await cameraController!.startVideoRecording();
      isRecording.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to start recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (!isRecording.value) return;

    try {
      final file = await cameraController!.stopVideoRecording();
      isRecording.value = false;

      final directory = await getTemporaryDirectory();
      final properVideoPath =
          '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      final recordedFile = File(file.path);
      final mp4File = await recordedFile.copy(properVideoPath);

      videoPath = mp4File.path;

      await submitVideo();
    } catch (e) {
      Get.snackbar('Error', 'Failed to stop recording: $e');
    }
  }

  Future<void> submitVideo() async {
    if (videoPath == null) return;

    isLoading.value = true;
    final currentQuestion = questions[currentQuestionIndex.value];
    final isLast = currentQuestionIndex.value == questions.length - 1;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://freepik.softvenceomega.com/in-prep/api/v1/video_process/process-video/'),
      );

      request.fields['qid'] = currentQuestion['_id'];
      request.fields['interview_id'] = interviewId.value;
      request.fields['questionBank_id'] = id.value;
      request.fields['user_id'] = userId.value;
      request.fields['isSummary'] = 'true';
      request.fields['islast'] = isLast.toString();
      request.fields['question'] = currentQuestion['question'];
      request.files
          .add(await http.MultipartFile.fromPath('file', videoPath!));

      print("The uploaded video path: $videoPath");

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      print('Response status: ${response.statusCode}');
      print('Response body: ${responseBody.body}');

      if (response.statusCode == 200) {
        lastResponse.value = jsonDecode(responseBody.body);
        Get.to(() => QuestionWiseFeedback());
      } else {
        Get.snackbar('Error', 'Failed to submit video');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit video: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      Get.offAll(StartInterviewView());
    } else {
      Get.offAll(OverAllFeedback());
    }
  }

  List<Map<String, dynamic>> toImprove = [
    {'title': 'Try to slow your speech slightly to improve clarity.'},
    {'title': 'Use hand gestures that emphasize your points.'},
    {
      'title':
          'Post-interview, enhance your body language. You excelled in eye contact and posture; just keep your arms relaxed and use gestures to highlight your points.'
    },
  ];

  Future<void> fetchUserProfile() async {
    try {
      String? token = await SharedPreferencesHelper.getAccessToken();
      if (token == null) {
        if (kDebugMode) {
          print("Token is null");
        }
        return;
      }

      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/users/getProfile'),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final data = body['data'];
        UserIdModel profile = UserIdModel.fromJson(data);
        userId.value = profile.id ?? '';
        if (kDebugMode) {
          print("Fetched User ID: ${userId.value}");
        }
      } else {
        if (kDebugMode) {
          print("Failed to fetch profile. Status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching profile: $e");
      }
    }
  }
}

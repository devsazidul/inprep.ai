import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart' show SharedPreferencesHelper;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/model/user_model.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/over_all_feedback.dart' show OverAllFeedback;
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/question_wise_feedback.dart' show QuestionWiseFeedback;
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/start_interview_view.dart' show StartInterviewView;
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class StartInterviewController extends GetxController {

  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxBool isRecording = false.obs;
  RxBool isVideoSaved = false.obs;
  RxInt recordingTime = 0.obs;
  Timer? recordingTimer;
  final maxRecordingTime = 180;  
  String? videoPath;
  var questionNumber = 1.obs; 
  var id = "".obs; 

   @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments;
    getQuestion();
    requestPermissions().then((_) => initializeCamera());

    print("The id is: ${id.value}");
  }


  var questions = <Map<String, dynamic>>[].obs;


  Future<bool> requestPermissions() async {
    bool hasCameraPermission = false;
    bool hasAudioPermission = false;
    bool hasStoragePermission = false;

    if (await Permission.camera.isDenied) {
      var status = await Permission.camera.request();
      hasCameraPermission = status.isGranted;
    } else {
      hasCameraPermission = await Permission.camera.isGranted;
    }
    if (await Permission.microphone.isDenied) {
      var status = await Permission.microphone.request();
      hasAudioPermission = status.isGranted;
    } else {
      hasAudioPermission = await Permission.microphone.isGranted;
    }
    if (Platform.isIOS) {
      if (await Permission.photos.isDenied) {
        var status = await Permission.photos.request();
        hasStoragePermission = status.isGranted || status.isLimited;
      } else {
        hasStoragePermission =
            await Permission.photos.isGranted ||
            await Permission.photos.isLimited;
      }
    } else if (Platform.isAndroid) {
      if (await Permission.storage.isDenied) {
        var status = await Permission.storage.request();
        hasStoragePermission = status.isGranted;
      } else {
        hasStoragePermission = await Permission.storage.isGranted;
      }
      var sdkInt = await DeviceInfoPlugin().androidInfo.then(
        (info) => info.version.sdkInt,
      );
      if (sdkInt >= 30 && !hasStoragePermission) {
        if (await Permission.manageExternalStorage.isDenied) {
          var status = await Permission.manageExternalStorage.request();
          hasStoragePermission = status.isGranted;
        } else {
          hasStoragePermission =
              await Permission.manageExternalStorage.isGranted;
        }
      }
    }
    if (!hasCameraPermission || !hasAudioPermission || !hasStoragePermission) {
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(
          title: 'Permissions Required',
          message:
              'Please grant camera, audio, and ${Platform.isIOS ? 'photo library' : 'storage'} permissions',
          duration: const Duration(seconds: 5),
          onTap: (_) => openAppSettings(),
        );
      }
    }
    return hasCameraPermission && hasAudioPermission && hasStoragePermission;
  }



  Future<void> initializeCamera() async {
    if (!await requestPermissions()) {
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(
          title: 'Error',
          message: 'Camera cannot be used without permissions',
          duration: const Duration(seconds: 5),
          onTap: (_) => openAppSettings(),
        );
      }
      return;
    }

    try {
       final cameras = await availableCameras().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Camera initialization timed out'),
      );

       final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => throw Exception('No front camera found'),
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: true,
      );

       await cameraController!.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Camera controller initialization timed out'),
      );

      isCameraInitialized.value = true;
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(
          title: 'Success',
          message: 'Front camera initialized successfully',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize front camera: $e');
      }
      isCameraInitialized.value = false;
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(
          title: 'Error',
          message: 'Failed to initialize camera: $e',
          duration: const Duration(seconds: 5),
          onTap: (_) => openAppSettings(),
        );
      }
    }
  }


  void onNextQuestion() {

    Get.to(() => QuestionWiseFeedback());
  }

  void onFeedbackNext() {
    if (questionNumber.value < questions.length) {
      questionNumber.value++;
      Get.off(() => StartInterviewView());
    } else {
      Get.off(() => OverAllFeedback());
    }
  }


  List <Map<String, dynamic>> toImprove = [
    {
      'title' : 'Try to slow your speech slightly to improve clarity.'
    },
    {
      'title' : 'Use hand gestures that emphasize your points.'
    },
    {
      'title' : 'Post-interview, enhance your body language. You excelled in eye contact and posture; just keep your arms relaxed and use gestures to highlight your points.'
    },
  ]; 



Future<void> getQuestion() async {
  try {
    String? token = await SharedPreferencesHelper.getAccessToken();

    final response = await http.get(
      Uri.parse('${Urls.baseUrl}/interview/genarateQuestionSet_ByAi?questionBank_id=${id.value}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':  token!,
      },
    );

    if (kDebugMode) {
      print("getQuestion() response: ${response.body}");
    }

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded['body'] != null &&
          decoded['body']['remainingQuestions'] != null &&
          decoded['body']['remainingQuestions'] is List) {
        questions.value =
            List<Map<String, dynamic>>.from(decoded['body']['remainingQuestions']);
        update();
      } else {
        if (kDebugMode) {
          print("Invalid format: 'remainingQuestions' not found");
        }
      }
    } else {
      if (kDebugMode) {
        print("Failed to fetch questions: ${response.statusCode}");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Exception in getQuestion(): $e");
    }
  }
}


 RxString userId = ''.obs;

  Future<void> fetchUserProfile() async {
    try {
      String? token = await SharedPreferencesHelper.getAccessToken();

      if (token == null) {
        print("Token is null");
        return;
      }

      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/users/getProfile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final data = body['data'];

        UserIdModel profile = UserIdModel.fromJson(data);
        userId.value = profile.id ?? '';

        print("Fetched User ID: ${userId.value}");
      } else {
        print("Failed to fetch profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }



  
}

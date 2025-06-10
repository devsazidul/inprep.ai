// File: lib/features/profile_setup.dart/controller/video_recording_controller.dart
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class VideoRecordingController extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxInt countdown = 3.obs;
  RxBool isCountdownActive = false.obs;
  RxBool isRecording = false.obs;
  RxInt remainingSeconds = 120.obs; // 120 seconds timer
  final int maxVideoDuration = 120; // 120 seconds

  List<CameraDescription> cameras = [];

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      // Find the front camera
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first, // Fallback to first camera if no front camera
      );
      
      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: true,
      );
      
      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize camera: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> startCountdownAndRecord() async {
    if (!isCameraInitialized.value) return;

    // Start countdown
    isCountdownActive.value = true;
    countdown.value = 3;
    while (countdown.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      countdown.value--;
    }
    isCountdownActive.value = false;

    // Start recording and timer
    try {
      await cameraController!.startVideoRecording();
      isRecording.value = true;
      remainingSeconds.value = maxVideoDuration;

      // Countdown timer for 120 seconds
      while (remainingSeconds.value > 0 && isRecording.value) {
        await Future.delayed(const Duration(seconds: 1));
        remainingSeconds.value--;
      }

      // Auto-stop if still recording after 120 seconds
      if (isRecording.value) {
        await stopRecording();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to start recording: $e',
          snackPosition: SnackPosition.BOTTOM);
      isRecording.value = false;
    }
  }

  Future<String?> stopRecording() async {
    if (!isRecording.value) return null;

    try {
      final XFile videoFile = await cameraController!.stopVideoRecording();
      isRecording.value = false;
      remainingSeconds.value = 120; // Reset timer
      return videoFile.path;
    } catch (e) {
      Get.snackbar('Error', 'Failed to stop recording: $e',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
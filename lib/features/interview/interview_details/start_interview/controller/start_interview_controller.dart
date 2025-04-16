import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
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

   @override
  void onInit() {
    super.onInit();
    requestPermissions().then((_) => initializeCamera());
  }


  List<Map<String, dynamic>> questions = [
    {'question': 'Can you explain the box model in CSS?'},
    {
      'question':
          'What are semantic HTML elements, and why are they important?',
    },
    {'question': 'Can you explain the box model in CSS?'},
    {'question': 'Can you explain the box model in CSS?'},
    {'question': 'Can you explain the box model in CSS?'},
  ];

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
}

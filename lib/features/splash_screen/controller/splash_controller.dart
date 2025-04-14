import 'package:get/get.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => Splash1Screen1());
    });
  }
}

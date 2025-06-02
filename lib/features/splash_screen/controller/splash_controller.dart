import 'package:get/get.dart';
import 'package:inprep_ai/core/services/shared_preferences_helper.dart' show SharedPreferencesHelper;
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() {
    Future.delayed(Duration(seconds: 3), () async{

      String? token = await SharedPreferencesHelper.getAccessToken();
      if(token != null){
        Get.offAll(() => BottomNavbarView());
      } 
      else{
        Get.offAll(() => Splash1Screen1());
      }
      
    });
  }
}

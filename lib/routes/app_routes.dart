import 'package:get/get.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/features/authentication/screen/signup_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_slider.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash_screen.dart';
import '../features/authentication/screen/change_password.dart'
    show ChangePassword;

class AppRoute {

  static String loginScreen = "/loginScreen";
  static String signupScreen = "/signupScreen";
  static String otpSentScreen = "/otpSentScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";
  static String otpSentScreen2 = "/otpSentScreen2";
  static String changePassword = "/changePassword";
  static String splashscreen = "/splashscreen";
  static String splash1Screen1 = "/splash1Screen1";
  static String profileslider = "/profileslider";

  static String getLoginScreen() => loginScreen;
  static String getSignupScreen() => signupScreen;
  static String getOtpSentScreen() => otpSentScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getOtpSentScreen2() => otpSentScreen2;
  static String getChangePassword() => changePassword;
  static String getsplashscreen() => splashscreen;
  static String getsplash1Screen1() => splash1Screen1;
  static String getprofileslider() => profileslider;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: changePassword, page: () => ChangePassword()),
    GetPage(name: splashscreen, page: () => SplashScreen()),
    GetPage(name: splash1Screen1, page: () => Splash1Screen1()),
    GetPage(name: profileslider, page: () => ProfileSlider()),
  ];
}

import 'package:get/get.dart';
import 'package:inprep_ai/features/authentication/screen/login_otp_send_screen.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/features/authentication/screen/otp_sent_screen.dart';
import 'package:inprep_ai/features/authentication/screen/signup_screen.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/genarated_about_me.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_slider.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash_screen.dart';
import 'package:inprep_ai/features/view_jobs/screen/view_job_screen.dart';
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
  static String viewJobScreen = "/viewJobScreen";
  static String bottomnavbarview = "/bottomnavbarview";
  static String loginOtpSendScreen = "/loginOtpSendScreen";
  static String genaratedaboutme = "/genaratedaboutme";

  static String getLoginScreen() => loginScreen;
  static String getSignupScreen() => signupScreen;
  static String getOtpSentScreen() => otpSentScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getOtpSentScreen2() => otpSentScreen2;
  static String getChangePassword() => changePassword;
  static String getsplashscreen() => splashscreen;
  static String getsplash1Screen1() => splash1Screen1;
  static String getviewJobScreen() => viewJobScreen;
  static String getprofileslider() => profileslider;
  static String getbottomnavbarview() => bottomnavbarview;
  static String getloginOtpSendScreen() => loginOtpSendScreen;
  static String getgenaratedaboutme() => genaratedaboutme;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: changePassword, page: () => ChangePassword()),
    GetPage(name: splashscreen, page: () => SplashScreen()),
    GetPage(name: splash1Screen1, page: () => Splash1Screen1()),
    GetPage(name: viewJobScreen, page: () => ViewJobScreen()),
    GetPage(name: profileslider, page: () => ProfileSlider()),
    GetPage(name: otpSentScreen, page: () => OTPScreen()),
    GetPage(name: bottomnavbarview, page: () => BottomNavbarView()),
    GetPage(name: loginOtpSendScreen, page: () => LoginOtpSendScreen()),
    GetPage(name: genaratedaboutme, page: () => GenaratedAboutMe()),
  ];
}

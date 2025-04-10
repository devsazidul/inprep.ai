import 'package:get/get.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/features/authentication/screen/signup_screen.dart';
import '../features/authentication/screen/change_password.dart'
    show ChangePassword;
import '../features/authentication/screen/forgot_password_screen.dart'
    show ForgotPasswordScreen;
import '../features/authentication/screen/otp_sent_screen.dart'
    show OtpSentScreen;
import '../features/authentication/screen/otp_sent_screen_2.dart'
    show OtpSentScreen2;

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String signupScreen = "/signupScreen";
  static String otpSentScreen = "/otpSentScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";
  static String otpSentScreen2 = "/otpSentScreen2";
  static String changePassword = "/changePassword";

  static String getLoginScreen() => loginScreen;
  static String getSignupScreen() => signupScreen;
  static String getOtpSentScreen() => otpSentScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getOtpSentScreen2() => otpSentScreen2;
  static String getChangePassword() => changePassword;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: otpSentScreen, page: () => OtpSentScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: otpSentScreen2, page: () => OtpSentScreen2()),
    GetPage(name: changePassword, page: () => ChangePassword()),
  ];
}

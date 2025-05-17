class Urls {
  static const String baseUrl =
      'https://ai-interview-server-3cg1.onrender.com/api/v1';
  static const String register = '$baseUrl/users/createUser';
  static const String getuser = '$baseUrl/users/getProfile';
  static const String verifyOtp = '$baseUrl/auth/otpcrossCheck';
  static const String resendOtp = '$baseUrl/auth/reSend_OTP';
  static const String sendOtp = '$baseUrl/auth/send_OTP';
  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '$baseUrl/auth/forgetPassword';
}

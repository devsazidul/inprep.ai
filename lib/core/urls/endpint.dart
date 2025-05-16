class Urls {
  static const String baseUrl =
      'https://ai-interview-server-3cg1.onrender.com/api/v1';
  static const String register = '$baseUrl/users/createUser';
  static const String verifyOtp = '$baseUrl/auth/otpcrossCheck';
  static const String sendOtp = '$baseUrl/auth/send_OTP';
  static const String login = '$baseUrl/auth/login';
  
}

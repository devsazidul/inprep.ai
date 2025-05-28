class Urls {
  static const String baseUrl =
      'https://ai-interview-server-3cg1.onrender.com/api/v1';
  static const String register = '$baseUrl/users/createUser';
  static const String getuser = '$baseUrl/users/getProfile';
  static const String updateProfile = '$baseUrl/users/updateProfile';
  static const String verifyOtp = '$baseUrl/auth/otpcrossCheck';
  static const String resendOtp = '$baseUrl/auth/reSend_OTP';
  static const String sendOtp = '$baseUrl/auth/send_OTP';
  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '$baseUrl/auth/forgetPassword';
  static const String resumeupload = '$baseUrl/resume/upload-resume';
  static const String updateresume = '$baseUrl/resume/update-resume';
  static const String changepassword = '$baseUrl/auth/resetPassword';
  static const String getAllSkills = '$baseUrl/skill/all-skills';
}

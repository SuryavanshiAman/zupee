

class ApiUrl{
  // base url
  static const String baseUrl = 'https://ludozupee.fctechteam.org/api/';
  // api url
  static const String sendOtp="https://otp.hopegamings.in/send_otp.php?";
  static const String verifyOtp="https://otp.hopegamings.in/verifyotp.php?";
  static const String authApi = '${baseUrl}login';
  static const String profileApi = '${baseUrl}profile?userid=';
  static const String updateProfileApi = '${baseUrl}updateprofile';
  static const String getSupportDataApi = '${baseUrl}getSupportData';
  static const String getAboutDataApi = '${baseUrl}getAboutData';
  static const String addAccountApi = '${baseUrl}addAccount';
  static const String accountViewApi = '${baseUrl}accountView';
}
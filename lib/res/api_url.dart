

class ApiUrl{
  static const String baseUrl = 'https://ludozupee.fctechteam.org/api/';
  static const String sendOtp="https://otp.fctechteam.org/send_otp.php?";
  static const String verifyOtp="https://otp.fctechteam.org/verifyotp.php?";
  static const String authApi = '${baseUrl}login';
  static const String profileApi = '${baseUrl}profile?userid=';
  static const String updateProfileApi = '${baseUrl}updateprofile';
  static const String getSupportDataApi = '${baseUrl}getSupportData';
  static const String getAboutDataApi = '${baseUrl}getAboutData';
  static const String addAccountApi = '${baseUrl}addAccount';
  static const String accountViewApi = '${baseUrl}accountView';
  static const String depositApi = "${baseUrl}payin";
  static const String withdrawApi = "${baseUrl}withdraw";
  static const String transactionHistoryApi = "${baseUrl}transaction_history?userid=";
  static const String contestCategoriesApi = "${baseUrl}contestcategories";
  static const String tournamentsApi = "${baseUrl}tournaments?category_id=";
  static const String joinTournamentApi = "${baseUrl}echekjoin-tournament";
  static const String joinApi = "${baseUrl}join-tournament";
  static const String sendResultApi = "${baseUrl}getResult";
  static const String userRank = "${baseUrl}getRankedUsers";
}
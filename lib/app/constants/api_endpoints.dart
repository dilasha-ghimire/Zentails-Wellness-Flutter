class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // ====================== Base URL ===========================
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  // =================== User Routes ===========================
  static const String register = "auth/register";
  static const String login = "auth/login";
}

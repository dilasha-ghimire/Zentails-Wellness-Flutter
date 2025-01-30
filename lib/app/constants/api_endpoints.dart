class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  //Base url
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  //Student routes
  static const String register = "auth/register";
  static const String login = "auth/login";
}

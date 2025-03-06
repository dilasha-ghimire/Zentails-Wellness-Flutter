class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // ====================== Base URL ===========================
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String imageUrlForUser =
      "http://10.0.2.2:3000/uploads/customers/";
  static const String imageUrlForPets = "http://10.0.2.2:3000/uploads/pets/";

  // static const String baseUrl = "http://192.168.10.103:3000/api/";
  // static const String imageUrlForUser =
  //     "http://192.168.10.103:3000/uploads/customers/";
  // static const String imageUrlForPets =
  //     "http://192.168.10.103:3000/uploads/pets/";

  // =================== User Routes ===========================
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String uploadImage = "customer/uploadImage";
  static const String getById = "customer";
  static const String updateById = "customer";

  // =================== Pet Routes ===========================
  static const String getPets = "pet";
  static const String getPetById = "pet/";

  // =================== Booking Routes ===========================
  static const String bookAppointment = "therapysessions";
  static const String getBookingByUserId = "therapysessions/user/";
}

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? authId;
  final String fullName;
  final String email;
  final String password;
  // password: temporary
  final String address;
  final String contactNumber;

  const AuthEntity(
      {this.authId,
      required this.fullName,
      required this.email,
      required this.password,
      required this.address,
      required this.contactNumber});

  @override
  List<Object?> get props =>
      [authId, fullName, email, password, address, contactNumber];
}

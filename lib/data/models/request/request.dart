import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String email;
  final String password;
  final String imei;
  final String deviceType;

  const LoginRequest(this.email, this.password, this.imei, this.deviceType);

  @override
  List<Object?> get props => [email, password, imei, deviceType];
}

class RegisterRequest extends Equatable {
  final String countryMobileCode;
  final String userName;
  final String email;
  final String password;
  final String profilePicture;
  final String mobileNumber;

  const RegisterRequest(this.countryMobileCode, this.userName, this.email,
      this.password, this.profilePicture, this.mobileNumber);

  @override
  List<Object?> get props => [
        countryMobileCode,
        userName,
        email,
        password,
        profilePicture,
        mobileNumber
      ];
}
